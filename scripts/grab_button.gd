class_name GrabButton
extends Button


const GRABBABLE_SCENE = preload("res://scenes/grabbable.tscn")

@export var fruit: Enums.Fruit_Type
@export var grab_type: Enums.Grabbable_Type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_up() -> void:
	if !Globals.is_grabbing:
		var grabbable = GRABBABLE_SCENE.instantiate()
		Globals.grabbable_fruit_type = fruit
		Globals.grabbable_grab_type = grab_type
		grabbable.initialize(fruit, grab_type, Enums.Fruit_Type.NONE)
		add_child(grabbable)
		Globals.is_grabbing = true
	elif Globals.is_grabbing and Globals.grabbable_fruit_type == fruit and Globals.grabbable_grab_type == grab_type:
		SignalManager.grabbable_placed.emit()
