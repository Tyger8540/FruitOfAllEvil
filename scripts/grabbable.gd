class_name Grabbable
extends Node2D

@export var top_blended_fruit: TextureRect
@export var bottom_blended_fruit: TextureRect

var fruit: Array[Enums.Fruit_Type]
var grab_type: Enums.Grabbable_Type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.grabbable_placed.connect(on_grabbable_placed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# needs to followe the mouse when it is currently grabbed!
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("right_click"):
		SignalManager.grabbable_placed.emit()


func initialize(fruit_types: Array[Enums.Fruit_Type], grabbable_type: Enums.Grabbable_Type):
	for i in fruit_types.size():
		if fruit.size() == i:
			fruit.append(Enums.Fruit_Type.NONE)
		fruit[i] = fruit_types[i]
	grab_type = grabbable_type
	match fruit[0]:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = Globals.BLENDED_CUP
					bottom_blended_fruit.texture = Globals.CUP_APPLE2
					match fruit[1]:
						Enums.Fruit_Type.APPLE:
							top_blended_fruit.texture = Globals.CUP_APPLE2  # TODO CHANGE FROM 2 ONCE CUSTOMER BUTTON IS FIGURED OUT
						Enums.Fruit_Type.ORANGE:
							top_blended_fruit.texture = Globals.CUP_ORANGE2
						Enums.Fruit_Type.BANANA:
							top_blended_fruit.texture = Globals.CUP_BANANA2
						Enums.Fruit_Type.BLUEBERRIES:
							top_blended_fruit.texture = Globals.CUP_BLUEBERRIES
						Enums.Fruit_Type.GRAPES:
							top_blended_fruit.texture = Globals.CUP_GRAPES
						Enums.Fruit_Type.NONE:
							top_blended_fruit.texture = null
					Globals.grabbable_sprite = Globals.BLENDED_CUP
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = Globals.BLENDED_CUP
					bottom_blended_fruit.texture = Globals.CUP_ORANGE2
					match fruit[1]:
						Enums.Fruit_Type.APPLE:
							top_blended_fruit.texture = Globals.CUP_APPLE2
						Enums.Fruit_Type.ORANGE:
							top_blended_fruit.texture = Globals.CUP_ORANGE2
						Enums.Fruit_Type.BANANA:
							top_blended_fruit.texture = Globals.CUP_BANANA2
						Enums.Fruit_Type.BLUEBERRIES:
							top_blended_fruit.texture = Globals.CUP_BLUEBERRIES
						Enums.Fruit_Type.GRAPES:
							top_blended_fruit.texture = Globals.CUP_GRAPES
						Enums.Fruit_Type.NONE:
							top_blended_fruit.texture = null
					Globals.grabbable_sprite = Globals.BLENDED_CUP
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = Globals.BLENDED_CUP
					bottom_blended_fruit.texture = Globals.CUP_BANANA2
					match fruit[1]:
						Enums.Fruit_Type.APPLE:
							top_blended_fruit.texture = Globals.CUP_APPLE2
						Enums.Fruit_Type.ORANGE:
							top_blended_fruit.texture = Globals.CUP_ORANGE2
						Enums.Fruit_Type.BANANA:
							top_blended_fruit.texture = Globals.CUP_BANANA2
						Enums.Fruit_Type.BLUEBERRIES:
							top_blended_fruit.texture = Globals.CUP_BLUEBERRIES
						Enums.Fruit_Type.GRAPES:
							top_blended_fruit.texture = Globals.CUP_GRAPES
						Enums.Fruit_Type.NONE:
							top_blended_fruit.texture = null
					Globals.grabbable_sprite = Globals.BLENDED_CUP
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.BLUEBERRIES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_BLUEBERRIES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = Globals.BLENDED_CUP
					bottom_blended_fruit.texture = Globals.CUP_BLUEBERRIES
					match fruit[1]:
						Enums.Fruit_Type.APPLE:
							top_blended_fruit.texture = Globals.CUP_APPLE2
						Enums.Fruit_Type.ORANGE:
							top_blended_fruit.texture = Globals.CUP_ORANGE2
						Enums.Fruit_Type.BANANA:
							top_blended_fruit.texture = Globals.CUP_BANANA2
						Enums.Fruit_Type.BLUEBERRIES:
							top_blended_fruit.texture = Globals.CUP_BLUEBERRIES
						Enums.Fruit_Type.GRAPES:
							top_blended_fruit.texture = Globals.CUP_GRAPES
						Enums.Fruit_Type.NONE:
							top_blended_fruit.texture = null
					Globals.grabbable_sprite = Globals.BLENDED_CUP
		Enums.Fruit_Type.GRAPES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.GRAPES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_GRAPES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					$Sprite2D.texture = Globals.BLENDED_CUP
					bottom_blended_fruit.texture = Globals.CUP_GRAPES
					match fruit[1]:
						Enums.Fruit_Type.APPLE:
							top_blended_fruit.texture = Globals.CUP_APPLE2
						Enums.Fruit_Type.ORANGE:
							top_blended_fruit.texture = Globals.CUP_ORANGE2
						Enums.Fruit_Type.BANANA:
							top_blended_fruit.texture = Globals.CUP_BANANA2
						Enums.Fruit_Type.BLUEBERRIES:
							top_blended_fruit.texture = Globals.CUP_BLUEBERRIES
						Enums.Fruit_Type.GRAPES:
							top_blended_fruit.texture = Globals.CUP_GRAPES
						Enums.Fruit_Type.NONE:
							top_blended_fruit.texture = null
					Globals.grabbable_sprite = Globals.BLENDED_CUP


func on_grabbable_placed() -> void:
	Globals.is_grabbing = false
	queue_free()
