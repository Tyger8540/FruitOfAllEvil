class_name ChoppingBoardButton
extends PlacePickupButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	super(_delta)


func place() -> void:
	if Globals.grabbable_grab_type == Enums.Grabbable_Type.FRUIT:
		$GrabbableTexture.texture = Globals.grabbable_sprite
		%Drop.play()
		is_occupied = true
		fruits[0] = Globals.grabbable_fruit_type[0]
		grab_types[0] = Globals.grabbable_grab_type
		Globals.grabbable_fruit_type[0] = Enums.Fruit_Type.NONE
		Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
	else:
		return
	
	# If this line was reached, the grabbable was able to be placed
	SignalManager.grabbable_placed.emit()


func pickup() -> void:
	if is_occupied:
		var grabbable = GRABBABLE_SCENE.instantiate()
		grabbable.initialize(fruits, grab_types[0])
		add_child(grabbable)
		%Grab.play()
		Globals.grabbable_fruit_type[0] = grabbable.fruit[0]
		Globals.grabbable_grab_type = grabbable.grab_type
		#if grab_types[0] == Enums.Grabbable_Type.FRUIT or grab_types[0] == Enums.Grabbable_Type.CHOPPED_FRUIT:
			#Globals.grabbable_fruit_type[1] = Enums.Fruit_Type.NONE
		$GrabbableTexture.texture = null
		is_occupied = false
		Globals.is_grabbing = true
		fruits[0] = Enums.Fruit_Type.NONE
		#fruits[1] = Enums.Fruit_Type.NONE
		grab_types[0] = Enums.Grabbable_Type.NONE
		#grab_types[1] = Enums.Grabbable_Type.NONE


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
