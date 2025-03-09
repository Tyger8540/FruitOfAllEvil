class_name ShelfButton
extends PlacePickupButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	fruits.append(Enums.Fruit_Type.NONE)
	temp_fruits.append(Enums.Fruit_Type.NONE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func on_day_start() -> void:
	pass


func place() -> void:
	$GrabbableTexture.texture = Globals.grabbable_sprite
	%Drop.play()
	is_occupied = true
	for i in Globals.grabbable_fruit_type.size():
		if Globals.grabbable_fruit_type[i] != Enums.Fruit_Type.NONE:
			fruits[i] = Globals.grabbable_fruit_type[i]
			Globals.grabbable_fruit_type[i] = Enums.Fruit_Type.NONE
		else:
			break
	grab_types[0] = Globals.grabbable_grab_type
	Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
	
	num_slots_filled += 1
	
	# If this line was reached, the grabbable was able to be placed
	SignalManager.grabbable_placed.emit()


func pickup() -> void:
	if temp_is_occupied:
		var grabbable = GRABBABLE_SCENE.instantiate()
		grabbable.initialize(temp_fruits, temp_grab_types[0])
		get_tree().get_root().add_child(grabbable)
		%Grab.play()
		Globals.grabbable_fruit_type[0] = grabbable.fruit[0]
		Globals.grabbable_grab_type = grabbable.grab_type
		Globals.grabbable_fruit_type[1] = grabbable.fruit[1]
		if temp_grab_types[0] == Enums.Grabbable_Type.FRUIT or temp_grab_types[0] == Enums.Grabbable_Type.CHOPPED_FRUIT:
			Globals.grabbable_fruit_type[1] = Enums.Fruit_Type.NONE
		if not swapping:
			$GrabbableTexture.texture = null
		temp_is_occupied = false
		Globals.is_grabbing = true
		temp_fruits[0] = Enums.Fruit_Type.NONE
		temp_fruits[1] = Enums.Fruit_Type.NONE
		temp_grab_types[0] = Enums.Grabbable_Type.NONE
		temp_num_slots_filled -= 1
	super()
