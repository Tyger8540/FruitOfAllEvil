class_name LustPair
extends Node2D

@export var lover1: LustCustomer
@export var lover2: LustCustomer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func initialize() -> void:
	# Make the pair spawn outside the bounds of the screen, then make their way in
	# to simulate people making their way to the ballroom
	pass
