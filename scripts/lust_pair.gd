class_name LustPair
extends Node2D

const LOVER_OFFSET = 70.0

@export var lover1: LustCustomer
@export var lover2: LustCustomer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func initialize(index: int) -> void:
	# Make the pair spawn outside the bounds of the screen, then make their way in
	# to simulate people making their way to the ballroom
	position = Vector2(-800.0 + 300.0 * index, 200.0)
	lover1.position.x -= LOVER_OFFSET
	lover2.position.x += LOVER_OFFSET
	pass
