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

@onready var left_sidescroll_button: SidescrollButton = $"../UI/LeftSidescrollButton"
@onready var right_sidescroll_button: SidescrollButton = $"../UI/RightSidescrollButton"
@onready var up_sidescroll_button: SidescrollButton = $"../UI/UpSidescrollButton"
@onready var down_sidescroll_button: SidescrollButton = $"../UI/DownSidescrollButton"
@onready var black_screen: ColorRect = $"../UI/BlackScreen"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.sidescrolled_left.connect(on_sidescrolled_left)
	SignalManager.sidescrolled_right.connect(on_sidescrolled_right)
	SignalManager.sidescrolled_up.connect(on_sidescrolled_up)
	SignalManager.sidescrolled_down.connect(on_sidescrolled_down)
	set_camera_position(position)
	set_sidescroll_button_visibility()
	#State.dialogue_ready = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if State.vendor == "Virgil" and position_index != 0:
		position_index = 0
		set_camera_position(Vector2(position_index * PAN_DISTANCE_X, 0.0))
	elif State.vendor == "Ovid" and position_index != 1:
		position_index = 1
		set_camera_position(Vector2(position_index * PAN_DISTANCE_X, 0.0))
	
	if position == new_position:
		if sidescrolling:
			# Finished sidescrolling, set buttons to correct visibility
			sidescrolling = false
			set_sidescroll_button_visibility()
	else:
		# Pan camera toward new position
		position = position.move_toward(new_position, PAN_SPEED * delta)
	
	if fading_out:
		print("hi")
		if black_screen.modulate.a >= 0.99:
			black_screen.modulate.a = 1.0
			fading_out = false
			on_faded_out()
		else:
			#black_screen.set("modulate", Color(1, 1, 1, FADE_FACTOR * delta))
			#black_screen.modulate = Color(1, 1, 1, black_screen.modulate.a + 1 / (FADE_FACTOR * delta))
			black_screen.modulate.a += FADE_FACTOR * delta
			print(black_screen.modulate.a)
	
	if fading_in:
		if black_screen.modulate.a <= 0.01:
			black_screen.modulate.a = 0.0
			fading_in = false
			on_faded_in()
		else:
			black_screen.modulate.a -= FADE_FACTOR * delta


func set_camera_position(pos: Vector2) -> void:
	# Set the new position for the camera to move to
	new_position = pos


func set_sidescroll_button_visibility() -> void:
	if position_index == 0:
		left_sidescroll_button.visible = false
	else:
		left_sidescroll_button.visible = true
	
	if position_index == max_index:
		right_sidescroll_button.visible = false
	else:
		right_sidescroll_button.visible = true


func update_num_vendors(_num_vendors: int) -> void:
	num_vendors = _num_vendors
	max_index = num_vendors - 1
	set_sidescroll_button_visibility()


func set_sidescroll_buttons_invisible() -> void:
	left_sidescroll_button.visible = false
	right_sidescroll_button.visible = false
	up_sidescroll_button.visible = false
	down_sidescroll_button.visible = false


func on_sidescrolled_left() -> void:
	if position == new_position:
		position_index -= 1
		set_sidescroll_buttons_invisible()
		set_camera_position(new_position + Vector2(-PAN_DISTANCE_X, 0.0))
		sidescrolling = true


func on_sidescrolled_right() -> void:
	if position == new_position:
		position_index += 1
		set_sidescroll_buttons_invisible()
		set_camera_position(new_position + Vector2(PAN_DISTANCE_X, 0.0))
		sidescrolling = true


func on_sidescrolled_up() -> void:
	# TODO
	# Hide sidescroll buttons
	# Fade out
	# Set camera position to 0, -1080
	# Fade back in
	# Show buttons
	set_sidescroll_buttons_invisible()
	queued_position = new_position + Vector2(0.0, -PAN_DISTANCE_Y)
	fading_out = true


func on_sidescrolled_down() -> void:
	# TODO
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
	pass


func on_faded_out() -> void:
	new_position = queued_position
	position = new_position
	queued_position = Vector2(0.0, 0.0)
	fading_in = true


func on_faded_in() -> void:
	set_sidescroll_button_visibility()
