class_name FarmersMarketCamera
extends Camera2D


const PAN_SPEED = 1920.0
const PAN_DISTANCE_X = 1920.0
const PAN_DISTANCE_Y = 1080.0
const FADE_FACTOR = 1.0

@export var num_vendors:= 1

var new_position: Vector2
var queued_position: Vector2
var position_index:= 0
var max_index:= num_vendors - 1

var sidescrolling:= false
var fading_out:= false
var fading_in:= false

var at_entrance:= true

@onready var left_sidescroll_button: SidescrollButton = $"../UI/SidescrollButtons/LeftSidescrollButton"
@onready var right_sidescroll_button: SidescrollButton = $"../UI/SidescrollButtons/RightSidescrollButton"
@onready var up_sidescroll_button: SidescrollButton = $"../UI/SidescrollButtons/UpSidescrollButton"
@onready var down_sidescroll_button: SidescrollButton = $"../UI/SidescrollButtons/DownSidescrollButton"
@onready var black_screen: ColorRect = $"../UI/BlackScreen"
@onready var sidescroll_buttons: Control = $"../UI/SidescrollButtons"
@onready var vendor_button: VendorButton = $"../UI/SidescrollButtons/VendorButton"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.sidescrolled_left.connect(on_sidescrolled_left)
	SignalManager.sidescrolled_right.connect(on_sidescrolled_right)
	SignalManager.sidescrolled_up.connect(on_sidescrolled_up)
	SignalManager.sidescrolled_down.connect(on_sidescrolled_down)
	SignalManager.market_dialogue_ended.connect(on_dialogue_ended)
	set_camera_position(position)
	set_sidescroll_button_visibility()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if State.vendor == "Virgil" and position_index != 0:
		#position_index = 0
		#set_camera_position(Vector2(position_index * PAN_DISTANCE_X, 0.0))
	#elif State.vendor == "Ovid" and position_index != 1:
		#position_index = 1
		#set_camera_position(Vector2(position_index * PAN_DISTANCE_X, 0.0))
	
	if position == new_position:
		if sidescrolling:
			# Finished sidescrolling, set buttons to correct visibility and set correct vendor
			set_vendor(position_index)
			sidescrolling = false
			set_sidescroll_button_visibility()
			vendor_button.set_label_visible(true)
	else:
		# Pan camera toward new position
		position = position.move_toward(new_position, PAN_SPEED * delta)
	
	if fading_out:
		if black_screen.modulate.a >= 0.99:
			black_screen.modulate.a = 1.0
			sidescroll_buttons.modulate.a = 0.0
			fading_out = false
			on_faded_out()
		else:
			#black_screen.set("modulate", Color(1, 1, 1, FADE_FACTOR * delta))
			#black_screen.modulate = Color(1, 1, 1, black_screen.modulate.a + 1 / (FADE_FACTOR * delta))
			black_screen.modulate.a += FADE_FACTOR * delta
			sidescroll_buttons.modulate.a -= FADE_FACTOR * delta
	
	if fading_in:
		if black_screen.modulate.a <= 0.01:
			black_screen.modulate.a = 0.0
			sidescroll_buttons.modulate.a = 1.0
			fading_in = false
			on_faded_in()
		else:
			black_screen.modulate.a -= FADE_FACTOR * delta
			sidescroll_buttons.modulate.a += FADE_FACTOR * delta


func set_camera_position(pos: Vector2) -> void:
	# Set the new position for the camera to move to
	new_position = pos


func set_sidescroll_button_visibility() -> void:
	if not at_entrance:  # Not at the entrance to the farmers market
		up_sidescroll_button.visible = false
		down_sidescroll_button.visible = true
		if position_index == 0:
			left_sidescroll_button.visible = false
		else:
			left_sidescroll_button.visible = true
		
		if position_index == max_index:
			right_sidescroll_button.visible = false
		else:
			right_sidescroll_button.visible = true
	else:  # At the entrance to the farmers market
		left_sidescroll_button.visible = false
		right_sidescroll_button.visible = false
		up_sidescroll_button.visible = true
		# Check if the player has completed the manatory chat w/ Virgil
		if State.circle_num == 0 and not State.received_blender:
			down_sidescroll_button.visible = false
		else:
			down_sidescroll_button.visible = true


func update_num_vendors(_num_vendors: int) -> void:
	num_vendors = _num_vendors
	max_index = num_vendors - 1
	set_sidescroll_button_visibility()


func set_sidescroll_buttons_invisible() -> void:
	left_sidescroll_button.visible = false
	right_sidescroll_button.visible = false
	up_sidescroll_button.visible = false
	down_sidescroll_button.visible = false
	vendor_button.set_label_visible(false)


func on_sidescrolled_left() -> void:
	if position == new_position:
		position_index -= 1
		set_sidescroll_buttons_invisible()
		set_camera_position(new_position + Vector2(-PAN_DISTANCE_X, 0.0))
		set_vendor()
		sidescrolling = true


func on_sidescrolled_right() -> void:
	if position == new_position:
		position_index += 1
		set_sidescroll_buttons_invisible()
		set_camera_position(new_position + Vector2(PAN_DISTANCE_X, 0.0))
		set_vendor()
		sidescrolling = true


func on_sidescrolled_up() -> void:
	# Fade out
	# Set camera position
	# Fade back in
	queued_position = position + Vector2(PAN_DISTANCE_X * position_index, -PAN_DISTANCE_Y)
	vendor_button.set_label_visible(false)
	fading_out = true


func on_sidescrolled_down() -> void:
	# 2 cases:
		# 1. At a vendor and want to go back to market entrance
			# Hide sidescroll buttons
			# Fade out
			# Set camera position to 0, 0
			# Fade back in
			# Show buttons
		# 2. At market entrance and want to go to next circle
			# Prompt the player
				# Ex1: You should check out the shop vendors before you continue your journey
				# Ex2: Continue to Circle X?
			# If choose to leave
				# Fade out
				# Fade into map movement / circle intro text
	
	if not at_entrance:  # Case 1
		queued_position = Vector2(0.0, 0.0)
		vendor_button.set_label_visible(false)
		set_vendor()
		fading_out = true
	else:  # Case 2
		# TODO Placeholder 2 lines below for showing that the player is trying to leave
		#queued_position = position + Vector2(0.0, 0.0)
		#fading_out = true
		start_leave_prompt()


func on_faded_out() -> void:
	# Set the camera's position based on what was queued from a button press
	new_position = queued_position
	position = new_position
	queued_position = Vector2(0.0, 0.0)  # Don't really need this line, just resetting it
	
	# Set where the player is ending up, entrance or vendors
	if is_zero_approx(position.y):
		at_entrance = true
	else:
		at_entrance = false
	
	# Set button visibility before fading back in for more seamless transitions
	set_sidescroll_button_visibility()
	fading_in = true


func on_faded_in() -> void:
	if at_entrance:
		# Set the current vendor to nothing
		set_vendor()
	else:
		# Set the current vendor
		set_vendor(position_index)
	vendor_button.set_label_visible(true)


func start_leave_prompt() -> void:
	State.section = "market_end"
	State.dialogue_ready = true
	set_sidescroll_buttons_invisible()
	# Prompt the player
		# Ex1: You should check out the shop vendors before you continue your journey
		# Ex2: Continue to Circle X?


func set_vendor(index = -1) -> void:
	if index == -1:
		State.vendor = ""
	else:
		State.vendor = %VendorController.vendor_names[index]


func on_dialogue_ended() -> void:
	set_sidescroll_button_visibility()
