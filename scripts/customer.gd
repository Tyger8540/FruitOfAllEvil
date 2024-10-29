class_name Customer
extends CharacterBody2D


const SPEED = 300.0

var stand_position: Vector2
var customer_index: int

var difficulty:= 1
var patience:= 1

var sell_value:= 0

@onready var panel: Panel = $CustomerButton/Panel

@onready var green_patience_bar: TextureProgressBar = $CustomerButton/GreenPatienceBar
@onready var red_patience_bar: TextureProgressBar = $CustomerButton/RedPatienceBar

@onready var green_patience_timer: Timer = $CustomerButton/GreenPatienceTimer
@onready var red_patience_timer: Timer = $CustomerButton/RedPatienceTimer

func _ready() -> void:
	SignalManager.customer_left.connect(on_customer_left)


func _process(delta: float) -> void:
	if green_patience_bar.visible and green_patience_bar.value > 0 and !green_patience_timer.is_stopped():
		green_patience_bar.value = green_patience_timer.time_left
	elif !red_patience_timer.is_stopped():
		red_patience_bar.value = red_patience_timer.time_left
	
	if position.x > stand_position.x:
		position.x = move_toward(position.x, stand_position.x, SPEED * delta)
	elif position.x < stand_position.x:
		position = stand_position
	else:
		# set the order panel once the customer reaches their stand_position, if panel not already visible
		if !panel.visible:
			panel.visible = true
			green_patience_bar.visible = true
			red_patience_bar.visible = true
			green_patience_timer.start()
	move_and_slide()


func initialize(texture: Texture2D, difficulty_level: int, patience_level: int, value: int, new_customer_index: int) -> void:
	$Sprite2D.texture = texture
	difficulty = difficulty_level
	patience = patience_level
	sell_value = value
	customer_index = new_customer_index
	set_patience_timers()
	set_stand_position(customer_index)
	form_options()


func die() -> void:
	SignalManager.customer_left.emit(customer_index)
	queue_free()


func set_stand_position(index: int) -> void:
	stand_position = Vector2(-915.0 + (index * 150), 0.0)


func set_patience_timers() -> void:
	green_patience_timer.wait_time = 32.0 - (2 * patience)
	green_patience_bar.max_value = green_patience_timer.wait_time
	red_patience_timer.wait_time = 2 * green_patience_timer.wait_time
	red_patience_bar.max_value = red_patience_timer.wait_time


func on_customer_left(index: int) -> void:
	if customer_index > index:
		customer_index -= 1
		set_stand_position(customer_index)


func form_options() -> void:
	var textures: Array[Texture2D]
	var fruits: Array[Enums.Fruit_Type]
	var grab_types: Array[Enums.Grabbable_Type]
	var fruits2: Array[Enums.Fruit_Type]
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
		if grab_types.back() == Enums.Grabbable_Type.BLENDED_FRUIT:
			var j = randi_range(1, 6)
			fruits2.append(get_random_fruit(j))
		else:
			fruits2.append(Enums.Fruit_Type.NONE)
		textures.append(get_texture(fruits.back(), grab_types.back(), fruits2.back()))
	$CustomerButton.set_grid(textures, fruits, grab_types, fruits2)


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
		6:
			return Enums.Fruit_Type.NONE
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


func get_texture(fruit: Enums.Fruit_Type, grab_type: Enums.Grabbable_Type, fruit2: Enums.Fruit_Type) -> Texture2D:
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.APPLE
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_APPLE
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							return Globals.CUP_APPLE_APPLE
						Enums.Fruit_Type.ORANGE:
							return Globals.CUP_APPLE_ORANGE
						Enums.Fruit_Type.BANANA:
							return Globals.CUP_APPLE_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							return Globals.CUP_APPLE_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							return Globals.CUP_APPLE_PLUM
						Enums.Fruit_Type.NONE:
							return Globals.CUP_APPLE
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.ORANGE
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_ORANGE
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							return Globals.CUP_ORANGE_APPLE
						Enums.Fruit_Type.ORANGE:
							return Globals.CUP_ORANGE_ORANGE
						Enums.Fruit_Type.BANANA:
							return Globals.CUP_ORANGE_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							return Globals.CUP_ORANGE_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							return Globals.CUP_ORANGE_PLUM
						Enums.Fruit_Type.NONE:
							return Globals.CUP_ORANGE
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.BANANA
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_BANANA
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							return Globals.CUP_BANANA_APPLE
						Enums.Fruit_Type.ORANGE:
							return Globals.CUP_BANANA_ORANGE
						Enums.Fruit_Type.BANANA:
							return Globals.CUP_BANANA_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							return Globals.CUP_BANANA_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							return Globals.CUP_BANANA_PLUM
						Enums.Fruit_Type.NONE:
							return Globals.CUP_BANANA
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.BLUEBERRIES
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_BLUEBERRIES
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							return Globals.CUP_BLUEBERRY_APPLE
						Enums.Fruit_Type.ORANGE:
							return Globals.CUP_BLUEBERRY_ORANGE
						Enums.Fruit_Type.BANANA:
							return Globals.CUP_BLUEBERRY_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							return Globals.CUP_BLUEBERRY_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							return Globals.CUP_BLUEBERRY_PLUM
						Enums.Fruit_Type.NONE:
							return Globals.CUP_BLUEBERRY
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.PLUM
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_PLUM
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							return Globals.CUP_PLUM_APPLE
						Enums.Fruit_Type.ORANGE:
							return Globals.CUP_PLUM_ORANGE
						Enums.Fruit_Type.BANANA:
							return Globals.CUP_PLUM_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							return Globals.CUP_PLUM_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							return Globals.CUP_PLUM_PLUM
						Enums.Fruit_Type.NONE:
							return Globals.CUP_PLUM
	return null


func _on_green_patience_timer_timeout() -> void:
	# remove the reward gained from completing this customer's order
	red_patience_timer.start()


func _on_red_patience_timer_timeout() -> void:
	SignalManager.life_lost.emit()
	$CustomerButton.start_leave_sequence()
