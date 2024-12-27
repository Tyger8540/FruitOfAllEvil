class_name FarmersMarketCamera
extends Camera2D


const PAN_SPEED = 200.0

var new_position: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		set_camera_position(new_position + Vector2(-500.0, 0.0))
	if Input.is_action_just_pressed("move_right"):
		set_camera_position(new_position + Vector2(500.0, 0.0))

	
	# Pan camera to new position
	if position != new_position:
		print("new_position: " + str(new_position))
		print("")
		print("position: " + str(position))
		position = position.move_toward(new_position, PAN_SPEED * delta)


func set_camera_position(pos: Vector2) -> void:
	new_position = pos
