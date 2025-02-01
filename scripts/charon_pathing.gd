extends PathFollow2D

var speed = 0.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		progress_ratio = 0.0
	
	loop_movement(delta)


func loop_movement(delta):
	progress_ratio += delta * speed
