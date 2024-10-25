class_name PlacePickupButton
extends Button


const GRABBABLE_SCENE = preload("res://scenes/grabbable.tscn")

const APPLE = preload("res://art/fruit/Apple.png")
const CHOPPED_APPLE = preload("res://art/fruit/AppleSlices.png")
const BLENDED_APPLE = preload("res://placeholder_art/Apple3.png")

const ORANGE = preload("res://art/fruit/Orange.png")
const CHOPPED_ORANGE = preload("res://placeholder_art/Orange2.png")
const BLENDED_ORANGE = preload("res://placeholder_art/Orange3.png")

const BANANA = preload("res://art/fruit/Banana.png")
const CHOPPED_BANANA = preload("res://art/fruit/BananaSlices.png")

const BLUEBERRIES = preload("res://art/fruit/Blueberries.png")
const CHOPPED_BLUEBERRIES = preload("res://art/fruit/BlueberrySlices.png")

const PLUM = preload("res://art/fruit/Plum.png")
const CHOPPED_PLUM = preload("res://art/fruit/PlumSlices.png")

@export var is_chop: bool
@export var is_blend: bool
@export var action_speed: float

var fruit: Enums.Fruit_Type
var grab_type: Enums.Grabbable_Type

var is_occupied:= false
var is_in_action:= false

@onready var action_button: Button = $ActionButton
@onready var action_timer: Timer = $ActionTimer
@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_chop:
		action_button.text = "CHOP"
	elif is_blend:
		action_button.text = "BLEND"
	
	action_timer.wait_time = action_speed
	progress_bar.max_value = action_timer.wait_time
	progress_bar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_in_action:
		progress_bar.value = action_timer.wait_time - action_timer.time_left


func _on_button_up() -> void:
	if Globals.is_grabbing and !is_occupied:
		# player is holding a grabbable and this button is to be placed on
		icon = Globals.grabbable_sprite
		is_occupied = true
		fruit = Globals.grabbable_fruit_type
		grab_type = Globals.grabbable_grab_type
		SignalManager.grabbable_placed.emit()
	elif !Globals.is_grabbing and is_occupied and !is_in_action:
		# player is not holding anything and this button has something on it to be picked up
		var grabbable = GRABBABLE_SCENE.instantiate()
		grabbable.initialize(fruit, grab_type)
		add_child(grabbable)
		Globals.grabbable_fruit_type = grabbable.fruit
		Globals.grabbable_grab_type = grabbable.grab_type
		icon = null
		is_occupied = false
		Globals.is_grabbing = true


func _on_action_button_button_up() -> void:
	if !is_in_action and grab_type == Enums.Grabbable_Type.FRUIT:
		is_in_action = true
		progress_bar.visible = true
		action_timer.start()


func _on_action_timer_timeout() -> void:
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = CHOPPED_APPLE
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = BLENDED_APPLE
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = CHOPPED_ORANGE
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = BLENDED_ORANGE
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = CHOPPED_BANANA
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					#elif is_blend:
						#icon = BLENDED_BANANA
						#grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = CHOPPED_BLUEBERRIES
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					#elif is_blend:
						#icon = BLENDED_BLUEBERRIES
						#grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = CHOPPED_PLUM
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					#elif is_blend:
						#icon = BLENDED_PLUM
						#grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
	is_in_action = false
	progress_bar.value = progress_bar.min_value
	progress_bar.visible = false
