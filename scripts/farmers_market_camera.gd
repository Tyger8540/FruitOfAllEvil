class_name FarmersMarketCamera
extends Camera2D


const PAN_SPEED = 1920.0
const PAN_DISTANCE = 1920.0

@export var num_vendors:= 1

var new_position: Vector2
var position_index:= 0
var max_index:= num_vendors - 1

var sidescrolling:= false

@onready var left_sidescroll_button: SidescrollButton = $"../UI/LeftSidescrollButton"
@onready var right_sidescroll_button: SidescrollButton = $"../UI/RightSidescrollButton"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.sidescrolled_left.connect(on_sidescrolled_left)
	SignalManager.sidescrolled_right.connect(on_sidescrolled_right)
	set_camera_position(position)
	set_sidescroll_button_visibility()
	State.dialogue_ready = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if State.vendor == "Virgil" and position_index != 0:
		position_index = 0
		set_camera_position(Vector2(0.0, 0.0))
	elif State.vendor == "Ovid" and position_index != 1:
		position_index = 1
		set_camera_position(Vector2(PAN_DISTANCE, 0.0))
	
	if position == new_position:
		if sidescrolling:
			# Finished sidescrolling, set buttons to correct visibility
			sidescrolling = false
			set_sidescroll_button_visibility()
		
		# OUTDATED - scrolling using A/D
		#if Input.is_action_just_pressed("move_left"):
			#set_camera_position(new_position + Vector2(-PAN_DISTANCE, 0.0))
		#if Input.is_action_just_pressed("move_right"):
			#set_camera_position(new_position + Vector2(PAN_DISTANCE, 0.0))
	else:
		# Pan camera toward new position
		position = position.move_toward(new_position, PAN_SPEED * delta)


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


func on_sidescrolled_left() -> void:
	if position == new_position:
		position_index -= 1
		set_camera_position(new_position + Vector2(-PAN_DISTANCE, 0.0))
		left_sidescroll_button.visible = false
		right_sidescroll_button.visible = false
		sidescrolling = true


func on_sidescrolled_right() -> void:
	if position == new_position:
		position_index += 1
		set_camera_position(new_position + Vector2(PAN_DISTANCE, 0.0))
		left_sidescroll_button.visible = false
		right_sidescroll_button.visible = false
		sidescrolling = true
