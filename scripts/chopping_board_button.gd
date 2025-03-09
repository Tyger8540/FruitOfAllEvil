class_name ChoppingBoardButton
extends PlacePickupButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	super(_delta)


func on_day_start() -> void:
	action_speed = 5 - (1.5 * Globals.upgrade_level[Enums.Upgrade_Type.CHOP_SPEED])
	clampf(action_speed, 0.0, 5.0)
	
	super()


func on_upgrade_purchased() -> void:
	if Globals.upgrade_level[Enums.Upgrade_Type.CHOPPING_BOARD] >= index and !visible:
		visible = true


func place() -> void:
	if Globals.grabbable_grab_type in [Enums.Grabbable_Type.FRUIT, Enums.Grabbable_Type.CHOPPED_FRUIT]:
		$GrabbableTexture.texture = Globals.grabbable_sprite
		%Drop.play()
		is_occupied = true
		fruits[0] = Globals.grabbable_fruit_type[0]
		grab_types[0] = Globals.grabbable_grab_type
		Globals.grabbable_fruit_type[0] = Enums.Fruit_Type.NONE
		Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
	else:
		if swapping:
			is_occupied = true
			fruits[0] = temp_fruits[0]
			grab_types[0] = temp_grab_types[0]
			num_slots_filled = 1
			temp_is_occupied = false
		return
	
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
		if temp_grab_types[0] == Enums.Grabbable_Type.FRUIT or temp_grab_types[0] == Enums.Grabbable_Type.CHOPPED_FRUIT:
			Globals.grabbable_fruit_type[1] = Enums.Fruit_Type.NONE
		if not swapping:
			$GrabbableTexture.texture = null
		temp_is_occupied = false
		Globals.is_grabbing = true
		temp_fruits[0] = Enums.Fruit_Type.NONE
		#fruits[1] = Enums.Fruit_Type.NONE
		temp_grab_types[0] = Enums.Grabbable_Type.NONE
		#grab_types[1] = Enums.Grabbable_Type.NONE
		temp_num_slots_filled -= 1
	super()


func start_action() -> void:
	if is_occupied:
		super()
		%Cut.play()


func finish_action() -> void:
	%Cut.stop()
	
	match fruits[0]:
		Enums.Fruit_Type.APPLE:
			$GrabbableTexture.texture = Globals.CHOPPED_APPLE
			grab_types[0] = Enums.Grabbable_Type.CHOPPED_FRUIT
		Enums.Fruit_Type.ORANGE:
			$GrabbableTexture.texture = Globals.CHOPPED_ORANGE
			grab_types[0] = Enums.Grabbable_Type.CHOPPED_FRUIT
		Enums.Fruit_Type.BANANA:
			$GrabbableTexture.texture = Globals.CHOPPED_BANANA
			grab_types[0] = Enums.Grabbable_Type.CHOPPED_FRUIT
		Enums.Fruit_Type.BLUEBERRIES:
			$GrabbableTexture.texture = Globals.CHOPPED_BLUEBERRIES
			grab_types[0] = Enums.Grabbable_Type.CHOPPED_FRUIT
		Enums.Fruit_Type.PLUM:
			$GrabbableTexture.texture = Globals.CHOPPED_PLUM
			grab_types[0] = Enums.Grabbable_Type.CHOPPED_FRUIT
	
	super()


func placeable() -> bool:
	if Globals.grabbable_grab_type in [Enums.Grabbable_Type.FRUIT, Enums.Grabbable_Type.CHOPPED_FRUIT]:
		return true
	else:
		return false
