class_name Customer
extends CharacterBody2D


const SPEED = 200.0

var stand_position: Vector2
var customer_index: int

var difficulty:= 1

@onready var panel: Panel = $CustomerButton/Panel


func _ready() -> void:
	SignalManager.customer_left.connect(on_customer_left)


func _physics_process(delta: float) -> void:
	if position.x > stand_position.x:
		position.x = move_toward(position.x, stand_position.x, SPEED * delta)
	elif position.x < stand_position.x:
		position = stand_position
	else:
		# set the order panel once the customer reaches their stand_position, if panel not already visible
		if !panel.visible:
			panel.visible = true
	move_and_slide()


func initialize(texture: Texture2D, difficulty_level: int, new_customer_index: int) -> void:
	$Sprite2D.texture = texture
	difficulty = difficulty_level
	customer_index = new_customer_index
	print("customer index: " + str(customer_index))
	set_stand_position(customer_index)
	form_options()


func die() -> void:
	SignalManager.customer_left.emit(customer_index)
	queue_free()


func set_stand_position(index: int) -> void:
	stand_position = Vector2(-915.0 + (index * 150), 0.0)


func on_customer_left(index: int) -> void:
	if customer_index > index:
		customer_index -= 1
		set_stand_position(customer_index)


func form_options() -> void:
	var textures: Array[Texture2D]
	var fruits: Array[Enums.Fruit_Type]
	var grab_types: Array[Enums.Grabbable_Type]
	var num_items: int
	var num_grab_types: int
	
	#region original code for num_items & num_grab_types before algorithms below
	#match difficulty:
		#1:
			#num_items = 1
			#num_grab_types = 1
		#2:
			#num_items = 1
			#num_grab_types = 2
		#3:
			#num_items = 1
			#num_grab_types = 3
		#4:
			#num_items = 2
			#num_grab_types = 1
		#5:
			#num_items = 2
			#num_grab_types = 2
		#6:
			#num_items = 2
			#num_grab_types = 3
		#7:
			#num_items = 3
			#num_grab_types = 1
		#8:
			#num_items = 3
			#num_grab_types = 2
		#9:
			#num_items = 3
			#num_grab_types = 3
		#10:
			#num_items = 4
			#num_grab_types = 1
		#11:
			#num_items = 4
			#num_grab_types = 2
		#12:
			#num_items = 4
			#num_grab_types = 3
	#endregion
	num_items = ceili(float(difficulty) / 3)
	num_grab_types = difficulty - (3 * (num_items - 1))
	for entry in num_items:
		var i = randi_range(1, 5)
		fruits.append(get_random_fruit(i))
		grab_types.append(get_random_grab_type(num_grab_types))
		textures.append(get_texture(fruits.back(), grab_types.back()))
		print("Slot " + str(entry) + ": " + str(fruits.back()) + ", " + str(grab_types.back()))
	$CustomerButton.set_grid(textures, fruits, grab_types)


func get_random_fruit(index: int) -> Enums.Fruit_Type:
	match index:
		1:
			return Enums.Fruit_Type.APPLE
		2:
			return Enums.Fruit_Type.ORANGE
		3:
			return Enums.Fruit_Type.BANANA
		4:
			return Enums.Fruit_Type.BLUEBERRIES
		5:
			return Enums.Fruit_Type.PLUM
	return Enums.Fruit_Type.NONE


func get_random_grab_type(num_types: int) -> Enums.Grabbable_Type:
	var i = randi_range(1, num_types)
	if i == 1:
		return Enums.Grabbable_Type.FRUIT
	elif i == 2:
		return Enums.Grabbable_Type.CHOPPED_FRUIT
	elif i == 3:
		return Enums.Grabbable_Type.BLENDED_FRUIT
	return Enums.Grabbable_Type.NONE


func get_texture(fruit: Enums.Fruit_Type, grab_type: Enums.Grabbable_Type) -> Texture2D:
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.APPLE
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_APPLE
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.BLENDED_APPLE
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.ORANGE
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_ORANGE
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.BLENDED_ORANGE
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.BANANA
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_BANANA
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.BLENDED_BANANA
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.BLUEBERRIES
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_BLUEBERRIES
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.BLENDED_BLUEBERRIES
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.PLUM
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_PLUM
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.BLENDED_PLUM
	return null
