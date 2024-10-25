class_name Grabbable
extends Node2D


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

var fruit: Enums.Fruit_Type
var grab_type: Enums.Grabbable_Type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.grabbable_placed.connect(on_grabbable_placed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# needs to followe the mouse when it is currently grabbed!
	global_position = get_global_mouse_position()

func initialize(fruit_type: Enums.Fruit_Type, grabbable_type: Enums.Grabbable_Type):
	fruit = fruit_type
	grab_type = grabbable_type
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = CHOPPED_APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = BLENDED_APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = CHOPPED_ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = BLENDED_ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = CHOPPED_BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
				#Enums.Grabbable_Type.BLENDED_FRUIT:
					#$Sprite2D.texture = BLENDED_BANANA
					#Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = BLUEBERRIES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = CHOPPED_BLUEBERRIES
					Globals.grabbable_sprite = $Sprite2D.texture
				#Enums.Grabbable_Type.BLENDED_FRUIT:
					#$Sprite2D.texture = BLENDED_BLUEBERRIES
					#Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = PLUM
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = CHOPPED_PLUM
					Globals.grabbable_sprite = $Sprite2D.texture
				#Enums.Grabbable_Type.BLENDED_FRUIT:
					#$Sprite2D.texture = BLENDED_PLUM
					#Globals.grabbable_sprite = $Sprite2D.texture


func on_grabbable_placed() -> void:
	Globals.is_grabbing = false
	queue_free()
