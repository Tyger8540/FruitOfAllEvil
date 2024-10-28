class_name PlacePickupButton
extends Button


const GRABBABLE_SCENE = preload("res://scenes/grabbable.tscn")
const BLEND_BUTTON = preload("res://art/other/BlendButton.png")
const CHOP_BUTTON = preload("res://art/other/ChopButton.png")

@export var is_chop: bool
@export var is_blend: bool
@export var action_speed: float
@export var index: int

var fruit: Enums.Fruit_Type
var grab_type: Enums.Grabbable_Type

var is_occupied:= false
var is_in_action:= false

@onready var action_button: Button = $ActionButton
@onready var action_timer: Timer = $ActionTimer
@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.day_started.connect(on_day_start)
	SignalManager.upgrade_purchased.connect(on_upgrade_purchased)
	if is_chop:
		action_button.icon = CHOP_BUTTON
	elif is_blend:
		action_button.icon = BLEND_BUTTON
	on_day_start()


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
	if !is_in_action and is_occupied and grab_type == Enums.Grabbable_Type.FRUIT:
		is_in_action = true
		progress_bar.visible = true
		action_timer.start()


func _on_action_timer_timeout() -> void:
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = Globals.CHOPPED_APPLE
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = Globals.BLENDED_APPLE
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = Globals.CHOPPED_ORANGE
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = Globals.BLENDED_ORANGE
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = Globals.CHOPPED_BANANA
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = Globals.BLENDED_BANANA
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = Globals.CHOPPED_BLUEBERRIES
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = Globals.BLENDED_BLUEBERRIES
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					if is_chop:
						icon = Globals.CHOPPED_PLUM
						grab_type = Enums.Grabbable_Type.CHOPPED_FRUIT
					elif is_blend:
						icon = Globals.BLENDED_PLUM
						grab_type = Enums.Grabbable_Type.BLENDED_FRUIT
	is_in_action = false
	progress_bar.value = progress_bar.min_value
	progress_bar.visible = false


func on_day_start() -> void:
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
	if is_chop and Globals.upgrade_level[Enums.Upgrade_Type.CHOPPING_BOARD] >= index and !visible:
		visible = true
	elif is_blend and Globals.upgrade_level[Enums.Upgrade_Type.BLENDER] >= index and !visible:
		visible = true
