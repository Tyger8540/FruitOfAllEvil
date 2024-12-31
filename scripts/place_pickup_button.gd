class_name PlacePickupButton
extends Button


const GRABBABLE_SCENE = preload("res://scenes/grabbable.tscn")
const BLENDER_OPEN = preload("res://art/other/Blender Open.png")
const BLENDER_EMPTY = preload("res://art/other/Blender Empty.png")
const CUTTING_BOARD = preload("res://art/other/Cutting Board.png")
const BLEND_BUTTON = preload("res://art/other/Blend Button.png")
const CHOP_BUTTON = preload("res://art/other/Chop Button.png")

@export var is_chop: bool
@export var is_blend: bool
@export var action_speed: float
@export var index: int

var fruit:= Enums.Fruit_Type.NONE
var fruit2:= Enums.Fruit_Type.NONE
var grab_type: Enums.Grabbable_Type
var grab_type2: Enums.Grabbable_Type

var is_occupied:= false
var is_in_action:= false
var is_half_occupied:= false

var pickup_icon: Texture2D

@onready var action_button: Button = $ActionButton
@onready var action_timer: Timer = $ActionTimer
@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.day_started.connect(on_day_start)
	SignalManager.upgrade_purchased.connect(on_upgrade_purchased)
	# Sets icons for the different appliances
	# TODO make this into a function that each child class will inherit to make things more concise
	#      once there are many appliances
	if is_chop:
		icon = CUTTING_BOARD
		action_button.icon = CHOP_BUTTON
	elif is_blend:
		icon = BLENDER_OPEN
		action_button.icon = BLEND_BUTTON
	on_day_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Provides a visual for the duration of an appliance's use
	if is_in_action:
		progress_bar.value = action_timer.wait_time - action_timer.time_left


func _on_button_up() -> void:
	# Triggers when the PlacePickupButton is clicked; accounts for if the player is holding an item
	# TODO figure out a way for the addition of multiple fruits to be handled in the appliances
	#      that are able to take multiple fruits, it is too complicated just in this function
	if Globals.is_grabbing and !is_occupied:
		# player is holding a grabbable and this button is to be placed on
		if is_blend and is_half_occupied:
			if Globals.grabbable_grab_type == Enums.Grabbable_Type.BLENDED_FRUIT:
				return
			$GrabbableTexture.texture = Globals.grabbable_sprite
			%Drop.play()
			is_occupied = true
			is_half_occupied = false
			fruit2 = Globals.grabbable_fruit_type
			grab_type2 = Globals.grabbable_grab_type
			Globals.grabbable_fruit_type = Enums.Fruit_Type.NONE
			Globals.grabbable_fruit_type2 = Enums.Fruit_Type.NONE
			Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
		elif is_blend:
			if Globals.grabbable_grab_type == Enums.Grabbable_Type.BLENDED_FRUIT:
				return  # THIS SHOULD FILL THE BLENDER BACK UP IN THEORY, BUT NOT ENOUGH TIME
			$GrabbableTexture2.texture = Globals.grabbable_sprite
			%Drop.play()
			is_half_occupied = true
			fruit = Globals.grabbable_fruit_type
			fruit2 = Globals.grabbable_fruit_type2
			grab_type = Globals.grabbable_grab_type
			Globals.grabbable_fruit_type = Enums.Fruit_Type.NONE
			Globals.grabbable_fruit_type2 = Enums.Fruit_Type.NONE
			Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
		else:
			$GrabbableTexture.texture = Globals.grabbable_sprite
			%Drop.play()
			is_occupied = true
			fruit = Globals.grabbable_fruit_type
			fruit2 = Globals.grabbable_fruit_type2
			grab_type = Globals.grabbable_grab_type
			Globals.grabbable_fruit_type = Enums.Fruit_Type.NONE
			Globals.grabbable_fruit_type2 = Enums.Fruit_Type.NONE
			Globals.grabbable_grab_type = Enums.Grabbable_Type.NONE
		SignalManager.grabbable_placed.emit()
	elif !Globals.is_grabbing and !is_in_action:
		# player is not holding anything and this button has something on it to be picked up
		if is_occupied and is_chop:
			var grabbable = GRABBABLE_SCENE.instantiate()
			grabbable.initialize(fruit, grab_type, fruit2)
			add_child(grabbable)
			%Grab.play()
			Globals.grabbable_fruit_type = grabbable.fruit
			Globals.grabbable_fruit_type2 = grabbable.fruit2
			Globals.grabbable_grab_type = grabbable.grab_type
			if grab_type == Enums.Grabbable_Type.FRUIT or grab_type == Enums.Grabbable_Type.CHOPPED_FRUIT:
				Globals.grabbable_fruit_type2 = Enums.Fruit_Type.NONE
			$GrabbableTexture.texture = null
			is_occupied = false
			Globals.is_grabbing = true
			fruit = Enums.Fruit_Type.NONE
			fruit2 = Enums.Fruit_Type.NONE
			grab_type = Enums.Grabbable_Type.NONE
			grab_type2 = Enums.Grabbable_Type.NONE
		elif is_blend and is_half_occupied:
			var grabbable = GRABBABLE_SCENE.instantiate()
			grabbable.initialize(fruit, grab_type, Enums.Fruit_Type.NONE)
			add_child(grabbable)
			%Grab.play()
			Globals.grabbable_fruit_type = grabbable.fruit
			Globals.grabbable_fruit_type2 = grabbable.fruit2
			Globals.grabbable_grab_type = grabbable.grab_type
			$GrabbableTexture2.texture = null
			is_half_occupied = false
			Globals.is_grabbing = true
			fruit = Enums.Fruit_Type.NONE
			fruit2 = Enums.Fruit_Type.NONE
			grab_type = Enums.Grabbable_Type.NONE
		elif is_blend and is_occupied:
			var grabbable = GRABBABLE_SCENE.instantiate()
			if grab_type == Enums.Grabbable_Type.BLENDED_FRUIT:  # already blended
				grabbable.initialize(fruit, grab_type, fruit2)
				add_child(grabbable)
				%Grab.play()
				Globals.grabbable_fruit_type = grabbable.fruit
				Globals.grabbable_grab_type = grabbable.grab_type
				Globals.grabbable_fruit_type2 = grabbable.fruit2
				is_occupied = false
				icon = BLENDER_EMPTY
				fruit = Enums.Fruit_Type.NONE
				fruit2 = Enums.Fruit_Type.NONE
				grab_type = Enums.Grabbable_Type.NONE
				grab_type2 = Enums.Grabbable_Type.NONE
				$GrabbableTexture.texture = null
			else:  # filled with 2 fruits but not blended
				grabbable.initialize(fruit2, grab_type2, Enums.Fruit_Type.NONE)
				add_child(grabbable)
				%Grab.play()
				Globals.grabbable_fruit_type = grabbable.fruit
				Globals.grabbable_fruit_type2 = grabbable.fruit2
				Globals.grabbable_grab_type = grabbable.grab_type
				is_half_occupied = true
				is_occupied = false
				$GrabbableTexture.texture = null
				fruit2 = Enums.Fruit_Type.NONE
				grab_type2 = Enums.Grabbable_Type.NONE
			Globals.is_grabbing = true


func _on_action_button_button_up() -> void:
	# Triggers when the appliance's power button is pressed
	# TODO similar to _on_button_up, make it simpler in this class to only deal with things
	#      that are single items, the half_occupied stuff will get very complicated with
	#      the addition of more appliances, which could possibly hold more than two
	#      fruits, which would make this even more complicated
	print("hi")
	if !is_in_action and (is_occupied or (is_blend and is_half_occupied)):
		if is_chop and grab_type == Enums.Grabbable_Type.FRUIT:
			is_in_action = true
			progress_bar.visible = true
			action_timer.start()
			%Cut.play()
		elif is_blend and grab_type == Enums.Grabbable_Type.FRUIT:
			if is_occupied:
				if grab_type2 == Enums.Grabbable_Type.FRUIT:
					is_in_action = true
					progress_bar.visible = true
					action_timer.start()
					%Blender.play()
			elif is_half_occupied:
				is_in_action = true
				progress_bar.visible = true
				action_timer.start()
				%Blender.play()


func _on_action_timer_timeout() -> void:
	# Triggers when the action has finished, i.e. chopping or blending
	# TODO simplify this function by calling another function that each child class will inherit,
	#      it can do simple stuff like the match statements, but the rest should be done within
	#      the subclasses I think
	if is_chop:
		%Cut.stop()
	elif is_blend:
		%Blender.stop()
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						$GrabbableTexture.texture = Globals.CHOPPED_APPLE
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						$GrabbableTexture2.texture = null
						if is_half_occupied: # blended a single fruit
							icon = Globals.BLENDER_APPLE
							grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
							is_half_occupied = false
							is_occupied = true
							fruit2 = Enums.Fruit_Type.NONE
						else:  # blended two fruits
							$GrabbableTexture.texture = null
							match fruit2:
								Enums.Fruit_Type.APPLE:
									icon = Globals.BLENDER_APPLE_APPLE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.ORANGE:
									icon = Globals.BLENDER_APPLE_ORANGE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BANANA:
									icon = Globals.BLENDER_APPLE_BANANA
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BLUEBERRIES:
									icon = Globals.BLENDER_APPLE_BLUEBERRY
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.PLUM:
									icon = Globals.BLENDER_APPLE_PLUM
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						$GrabbableTexture.texture = Globals.CHOPPED_ORANGE
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						$GrabbableTexture2.texture = null
						if is_half_occupied: # blended a single fruit
							icon = Globals.BLENDER_ORANGE
							grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
							is_half_occupied = false
							is_occupied = true
							fruit2 = Enums.Fruit_Type.NONE
						else:  # blended two fruits
							$GrabbableTexture.texture = null
							match fruit2:
								Enums.Fruit_Type.APPLE:
									icon = Globals.BLENDER_ORANGE_APPLE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.ORANGE:
									icon = Globals.BLENDER_ORANGE_ORANGE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BANANA:
									icon = Globals.BLENDER_ORANGE_BANANA
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BLUEBERRIES:
									icon = Globals.BLENDER_ORANGE_BLUEBERRY
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.PLUM:
									icon = Globals.BLENDER_ORANGE_PLUM
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						$GrabbableTexture.texture = Globals.CHOPPED_BANANA
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						$GrabbableTexture2.texture = null
						if is_half_occupied: # blended a single fruit
							icon = Globals.BLENDER_BANANA
							grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
							is_half_occupied = false
							is_occupied = true
							fruit2 = Enums.Fruit_Type.NONE
						else:  # blended two fruits
							$GrabbableTexture.texture = null
							match fruit2:
								Enums.Fruit_Type.APPLE:
									icon = Globals.BLENDER_BANANA_APPLE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.ORANGE:
									icon = Globals.BLENDER_BANANA_ORANGE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BANANA:
									icon = Globals.BLENDER_BANANA_BANANA
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BLUEBERRIES:
									icon = Globals.BLENDER_BANANA_BLUEBERRY
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.PLUM:
									icon = Globals.BLENDER_BANANA_PLUM
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						$GrabbableTexture.texture = Globals.CHOPPED_BLUEBERRIES
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						$GrabbableTexture2.texture = null
						if is_half_occupied: # blended a single fruit
							icon = Globals.BLENDER_BLUEBERRY
							grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
							is_half_occupied = false
							is_occupied = true
							fruit2 = Enums.Fruit_Type.NONE
						else:  # blended two fruits
							$GrabbableTexture.texture = null
							match fruit2:
								Enums.Fruit_Type.APPLE:
									icon = Globals.BLENDER_BLUEBERRY_APPLE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.ORANGE:
									icon = Globals.BLENDER_BLUEBERRY_ORANGE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BANANA:
									icon = Globals.BLENDER_BLUEBERRY_BANANA
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BLUEBERRIES:
									icon = Globals.BLENDER_BLUEBERRY_BLUEBERRY
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.PLUM:
									icon = Globals.BLENDER_BLUEBERRY_PLUM
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						$GrabbableTexture.texture = Globals.CHOPPED_PLUM
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						$GrabbableTexture2.texture = null
						if is_half_occupied: # blended a single fruit
							icon = Globals.BLENDER_PLUM
							grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
							is_half_occupied = false
							is_occupied = true
							fruit2 = Enums.Fruit_Type.NONE
						else:  # blended two fruits
							$GrabbableTexture.texture = null
							match fruit2:
								Enums.Fruit_Type.APPLE:
									icon = Globals.BLENDER_PLUM_APPLE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.ORANGE:
									icon = Globals.BLENDER_PLUM_ORANGE
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BANANA:
									icon = Globals.BLENDER_PLUM_BANANA
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.BLUEBERRIES:
									icon = Globals.BLENDER_PLUM_BLUEBERRY
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
								Enums.Fruit_Type.PLUM:
									icon = Globals.BLENDER_PLUM_PLUM
									grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
	is_in_action = false
	progress_bar.value = progress_bar.min_value
	progress_bar.visible = false


func on_day_start() -> void:
	# Sets the speed of appliances after the shopping phase has ended, as they could be upgraded
	if is_chop:
		action_speed = 5 - (1.5 * Globals.upgrade_level[Enums.Upgrade_Type.CHOP_SPEED])
		clampf(action_speed, 0.0, 5.0)
	elif is_blend:
		action_speed = 8 - (2 * Globals.upgrade_level[Enums.Upgrade_Type.BLEND_SPEED])
		clampf(action_speed, 0.0, 8.0)
	action_timer.wait_time = action_speed
	progress_bar.max_value = action_timer.wait_time
	progress_bar.visible = false


func on_upgrade_purchased() -> void:
	# Checks if an appliance has been purchased, in which case a new one should be visible
	if is_chop and Globals.upgrade_level[Enums.Upgrade_Type.CHOPPING_BOARD] >= index and !visible:
		visible = true
	elif is_blend and Globals.upgrade_level[Enums.Upgrade_Type.BLENDER] >= index and !visible:
		visible = true
