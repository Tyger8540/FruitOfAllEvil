class_name BlenderButton
extends PlacePickupButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	super(_delta)


func on_day_start() -> void:
	action_speed = 8 - (2 * Globals.upgrade_level[Enums.Upgrade_Type.BLEND_SPEED])
	clampf(action_speed, 0.0, 8.0)
	
	super()


func on_upgrade_purchased() -> void:
	if Globals.upgrade_level[Enums.Upgrade_Type.BLENDER] >= index and !visible:
		visible = true


func place() -> void:
	if (
			Globals.grabbable_grab_type == Enums.Grabbable_Type.FRUIT or
			Globals.grabbable_grab_type == Enums.Grabbable_Type.CHOPPED_FRUIT
	):
		# Grabbable is blendable (not necessarily just a regular fruit)
		if is_part_occupied:
			$GrabbableTexture.texture = Globals.grabbable_sprite
		else:
			$GrabbableTexture2.texture = Globals.grabbable_sprite
		%Drop.play()
		fruits[num_slots_filled] = Globals.grabbable_fruit_type[0]
		grab_types[num_slots_filled] = Globals.grabbable_grab_type
		for i in num_slots:
			Globals.grabbable_fruit_type[i] = Enums.Fruit_Type.NONE
			Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
		num_slots_filled += 1
	else:
		return
	
	if num_slots_filled == num_slots:
		is_occupied = true
		is_part_occupied = false
	else:
		is_occupied = false
		is_part_occupied = true
	
	# If this line was reached, the grabbable was able to be placed
	SignalManager.grabbable_placed.emit()


func pickup() -> void:
	if is_part_occupied:
		# not blended (changes to occupied once blended)
		var grabbable = GRABBABLE_SCENE.instantiate()
		grabbable.initialize(fruits, grab_types[0])
		add_child(grabbable)
		%Grab.play()
		Globals.grabbable_fruit_type[0] = grabbable.fruit[0]
		Globals.grabbable_fruit_type[1] = grabbable.fruit[1]
		Globals.grabbable_grab_type = grabbable.grab_type
		$GrabbableTexture2.texture = null
		is_part_occupied = false
		Globals.is_grabbing = true
		fruits[0] = Enums.Fruit_Type.NONE
		fruits[1] = Enums.Fruit_Type.NONE
		grab_types[0] = Enums.Grabbable_Type.NONE
		num_slots_filled -= 1
	elif is_occupied:
		var grabbable = GRABBABLE_SCENE.instantiate()
		if grab_types[0] == Enums.Grabbable_Type.BLENDED_FRUIT:  # already blended
			grabbable.initialize(fruits, grab_types[0])
			add_child(grabbable)
			%Grab.play()
			Globals.grabbable_fruit_type[0] = grabbable.fruit[0]
			Globals.grabbable_grab_type = grabbable.grab_type
			Globals.grabbable_fruit_type[1] = grabbable.fruit[1]
			is_occupied = false
			icon = BLENDER_EMPTY
			fruits[0] = Enums.Fruit_Type.NONE
			fruits[1] = Enums.Fruit_Type.NONE
			grab_types[0] = Enums.Grabbable_Type.NONE
			grab_types[1] = Enums.Grabbable_Type.NONE
			$GrabbableTexture.texture = null
			num_slots_filled -= 2
		else:  # filled with 2 fruits but not blended
			var fruit_array: Array[Enums.Fruit_Type]
			fruit_array.append(fruits[1])
			grabbable.initialize(fruit_array, grab_types[1])
			add_child(grabbable)
			%Grab.play()
			Globals.grabbable_fruit_type[0] = grabbable.fruit[0]
			Globals.grabbable_grab_type = grabbable.grab_type
			is_part_occupied = true
			is_occupied = false
			$GrabbableTexture.texture = null
			fruits[1] = Enums.Fruit_Type.NONE
			grab_types[1] = Enums.Grabbable_Type.NONE
			num_slots_filled -= 1
		Globals.is_grabbing = true


func start_action() -> void:
	if is_occupied or is_part_occupied:
		super()
		%Blender.play()


func finish_action() -> void:
	%Blender.stop()
	
	match fruits[0]:
		Enums.Fruit_Type.APPLE:
			$GrabbableTexture2.texture = null
			if is_part_occupied: # blended a single fruit
				icon = Globals.BLENDER_APPLE
				grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
				is_part_occupied = false
				is_occupied = true
				fruits[1] = Enums.Fruit_Type.NONE
			else:  # blended two fruits
				$GrabbableTexture.texture = null
				match fruits[1]:
					Enums.Fruit_Type.APPLE:
						icon = Globals.BLENDER_APPLE_APPLE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.ORANGE:
						icon = Globals.BLENDER_APPLE_ORANGE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BANANA:
						icon = Globals.BLENDER_APPLE_BANANA
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BLUEBERRIES:
						icon = Globals.BLENDER_APPLE_BLUEBERRY
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.PLUM:
						icon = Globals.BLENDER_APPLE_PLUM
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.ORANGE:
			$GrabbableTexture2.texture = null
			if is_part_occupied: # blended a single fruit
				icon = Globals.BLENDER_ORANGE
				grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
				is_part_occupied = false
				is_occupied = true
				fruits[1] = Enums.Fruit_Type.NONE
			else:  # blended two fruits
				$GrabbableTexture.texture = null
				match fruits[1]:
					Enums.Fruit_Type.APPLE:
						icon = Globals.BLENDER_ORANGE_APPLE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.ORANGE:
						icon = Globals.BLENDER_ORANGE_ORANGE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BANANA:
						icon = Globals.BLENDER_ORANGE_BANANA
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BLUEBERRIES:
						icon = Globals.BLENDER_ORANGE_BLUEBERRY
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.PLUM:
						icon = Globals.BLENDER_ORANGE_PLUM
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BANANA:
			$GrabbableTexture2.texture = null
			if is_part_occupied: # blended a single fruit
				icon = Globals.BLENDER_BANANA
				grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
				is_part_occupied = false
				is_occupied = true
				fruits[1] = Enums.Fruit_Type.NONE
			else:  # blended two fruits
				$GrabbableTexture.texture = null
				match fruits[1]:
					Enums.Fruit_Type.APPLE:
						icon = Globals.BLENDER_BANANA_APPLE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.ORANGE:
						icon = Globals.BLENDER_BANANA_ORANGE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BANANA:
						icon = Globals.BLENDER_BANANA_BANANA
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BLUEBERRIES:
						icon = Globals.BLENDER_BANANA_BLUEBERRY
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.PLUM:
						icon = Globals.BLENDER_BANANA_PLUM
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BLUEBERRIES:
			$GrabbableTexture2.texture = null
			if is_part_occupied: # blended a single fruit
				icon = Globals.BLENDER_BLUEBERRY
				grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
				is_part_occupied = false
				is_occupied = true
				fruits[1] = Enums.Fruit_Type.NONE
			else:  # blended two fruits
				$GrabbableTexture.texture = null
				match fruits[1]:
					Enums.Fruit_Type.APPLE:
						icon = Globals.BLENDER_BLUEBERRY_APPLE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.ORANGE:
						icon = Globals.BLENDER_BLUEBERRY_ORANGE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BANANA:
						icon = Globals.BLENDER_BLUEBERRY_BANANA
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BLUEBERRIES:
						icon = Globals.BLENDER_BLUEBERRY_BLUEBERRY
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.PLUM:
						icon = Globals.BLENDER_BLUEBERRY_PLUM
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.PLUM:
			$GrabbableTexture2.texture = null
			if is_part_occupied: # blended a single fruit
				icon = Globals.BLENDER_PLUM
				grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
				is_part_occupied = false
				is_occupied = true
				fruits[1] = Enums.Fruit_Type.NONE
			else:  # blended two fruits
				$GrabbableTexture.texture = null
				match fruits[1]:
					Enums.Fruit_Type.APPLE:
						icon = Globals.BLENDER_PLUM_APPLE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.ORANGE:
						icon = Globals.BLENDER_PLUM_ORANGE
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BANANA:
						icon = Globals.BLENDER_PLUM_BANANA
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.BLUEBERRIES:
						icon = Globals.BLENDER_PLUM_BLUEBERRY
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
					Enums.Fruit_Type.PLUM:
						icon = Globals.BLENDER_PLUM_PLUM
						grab_types[0] = Enums.Grabbable_Type.BLENDED_FRUIT
	
	super()
