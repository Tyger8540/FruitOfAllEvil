class_name GrabButton
extends TextureButton


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
		grab_fruit()
	elif Globals.is_grabbing:
		if Globals.grabbable_grab_type == grab_type:
			SignalManager.grabbable_placed.emit()
			if Globals.grabbable_fruit_type[0] == fruit:
				%PlaceOrGrabBackup.play()
			else:
				grab_fruit()


func grab_fruit() -> void:
	var grabbable = GRABBABLE_SCENE.instantiate()
	%Grab.play()
	Globals.grabbable_fruit_type[0] = fruit
	Globals.grabbable_grab_type = grab_type
	if grab_type == Enums.Grabbable_Type.FRUIT or grab_type == Enums.Grabbable_Type.CHOPPED_FRUIT:
		Globals.grabbable_fruit_type[1] = Enums.Fruit_Type.NONE
	var fruit_array: Array[Enums.Fruit_Type]
	fruit_array.append(fruit)
	grabbable.initialize(fruit_array, grab_type)
	get_tree().get_root().add_child(grabbable)
	Globals.is_grabbing = true
