class_name FarmersMarketCamera
extends Camera2D


const PAN_SPEED = 1152.0
const PAN_DISTANCE = 1152.0

var new_position: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position == new_position:
		if Input.is_action_just_pressed("move_left"):
			set_camera_position(new_position + Vector2(-PAN_DISTANCE, 0.0))
		if Input.is_action_just_pressed("move_right"):
			set_camera_position(new_position + Vector2(PAN_DISTANCE, 0.0))
	else:
		# Pan camera toward new position
		position = position.move_toward(new_position, PAN_SPEED * delta)


func set_camera_position(pos: Vector2) -> void:
	new_position = pos
