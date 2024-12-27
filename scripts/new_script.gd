extends Node


var move_distance:= 50.0
var goal_x:= -1000

@export var snail1: Sprite2D
@export var snail2: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if snail1.position.x <= goal_x:
		print("Player 1 Wins!")
	elif snail2.position.x <= goal_x:
		print("Player 2 Wins!")


func _input(event: InputEvent) -> void:
	if event.is_action_released("space"):
		snail1.position.x -= move_distance
	elif event.is_action_released("enter"):
		snail2.position.x -= move_distance
