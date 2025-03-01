class_name PlacePickupButton
extends Button


enum Appliance_Type {
	NONE,
	CHOPPING_BOARD,
	BLENDER,
	SHELF,
}

const GRABBABLE_SCENE = preload("res://scenes/grabbable.tscn")
const BLENDER_OPEN = preload("res://final_art/Blender.png")
const BLENDER_EMPTY = preload("res://final_art/Blender.png")
const CUTTING_BOARD = preload("res://art/other/Cutting Board.png")
const BLEND_BUTTON = preload("res://art/other/Blend Button.png")
const CHOP_BUTTON = preload("res://art/other/Chop Button.png")

@export var appliance_type: Appliance_Type
@export var num_slots: int
@export var action_speed: float
@export var index: int
@export var appliance_icon: CompressedTexture2D
@export var action_icon: CompressedTexture2D

# Arrays that hold the fruits and grab types of those fruits
var fruits: Array[Enums.Fruit_Type]
var grab_types: Array[Enums.Grabbable_Type]

var is_occupied:= false
var is_in_action:= false
var is_part_occupied:= false
var num_slots_filled:= 0

var swapping:= false

# Temporary arrays that hold the fruits and grab types of those fruits
var temp_fruits: Array[Enums.Fruit_Type]
var temp_grab_types: Array[Enums.Grabbable_Type]

var temp_is_occupied:= false
var temp_is_part_occupied:= false
var temp_num_slots_filled:= 0

@onready var action_button: Button = $ActionButton
@onready var action_timer: Timer = $ActionTimer
@onready var progress_bar: ProgressBar = $ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.day_started.connect(on_day_start)
	SignalManager.upgrade_purchased.connect(on_upgrade_purchased)
	
	# Sets icons for the appliance & its action button (if it has one)
	icon = appliance_icon
	if appliance_type != Appliance_Type.SHELF:
		action_button.icon = action_icon
	
	# Sets the correct size for the fruit and grab_type arrays by appending NONE values
	for i in num_slots:
		fruits.append(Enums.Fruit_Type.NONE)
		grab_types.append(Enums.Fruit_Type.NONE)
	
	on_day_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Provides a visual for the duration of an appliance's use
	if is_in_action:
		progress_bar.value = action_timer.wait_time - action_timer.time_left


func on_day_start() -> void:
	# Sets the speed of appliances after the shopping phase has ended, as they could be upgraded
	
	action_timer.wait_time = action_speed
	progress_bar.max_value = action_timer.wait_time
	progress_bar.visible = false


func on_upgrade_purchased() -> void:
	# Checks if an appliance has been purchased, in which case a new one should be visible
	pass


func place() -> void:
	pass


func pickup() -> void:
	if not swapping:
		print("not swapping")
		set_vars()
	else:
		print("swapping")
		swapping = false


func set_temp_vars() -> void:
	temp_fruits = fruits
	print("temp fruits: " + str(temp_fruits))
	print("fruits: " + str(fruits))
	temp_grab_types = grab_types
	temp_is_occupied = is_occupied
	temp_is_part_occupied = is_part_occupied
	temp_num_slots_filled = num_slots_filled
	print("set_temp_vars end")


func set_vars() -> void:
	fruits = temp_fruits
	grab_types = temp_grab_types
	is_occupied = temp_is_occupied
	is_part_occupied = temp_is_part_occupied
	num_slots_filled = temp_num_slots_filled


func clear() -> void:
	for i in fruits.size():
		fruits[i] = Enums.Fruit_Type.NONE
	grab_types[0] = Enums.Grabbable_Type.NONE
	is_occupied = false
	is_part_occupied = false
	num_slots_filled = 0


func swap() -> void:
	swapping = true
	set_temp_vars()
	clear()
	place()
	pickup()


func start_action() -> void:
	is_in_action = true
	progress_bar.visible = true
	action_timer.start()


func finish_action() -> void:
	is_in_action = false
	progress_bar.value = progress_bar.min_value
	progress_bar.visible = false


func _on_button_up() -> void:
	# Triggers when the PlacePickupButton is clicked; accounts for if the player is holding an item
	if Globals.is_grabbing and not is_occupied and not is_in_action:
		# Player is holding a grabbable and this button is unoccupied and to be placed on
		place()
	elif not Globals.is_grabbing and not is_in_action:
		# Player is not holding anything and this button has something on it to be picked up
		set_temp_vars()
		pickup()
	elif Globals.is_grabbing and is_occupied and not is_in_action:
		# Player is holding a grabbable and this button is occupied, leading to a swap
		swap()
	


func _on_action_button_button_up() -> void:
	# Triggers when the appliance's power button is pressed
	if !is_in_action:
		start_action()


func _on_action_timer_timeout() -> void:
	# Triggers when the action has finished, i.e. chopping or blending
	
	# Takes care of anything needed when the action finishes (sounds, icons, etc.)
	finish_action()
	
	# Template for match statement in finish_action
	#match fruits[0]:
		#Enums.Fruit_Type.APPLE:
			#pass
		#Enums.Fruit_Type.ORANGE:
			#pass
		#Enums.Fruit_Type.BANANA:
			#pass
		#Enums.Fruit_Type.BLUEBERRIES:
			#pass
		#Enums.Fruit_Type.PLUM:
			#pass
