class_name SidescrollingPlayer
extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	# Check for moving left or right
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0.0

	move_and_slide()
