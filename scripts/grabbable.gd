class_name Grabbable
extends Node2D


var fruit: Enums.Fruit_Type
var grab_type: Enums.Grabbable_Type
var fruit2: Enums.Fruit_Type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.grabbable_placed.connect(on_grabbable_placed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# needs to followe the mouse when it is currently grabbed!
	global_position = get_global_mouse_position()

func initialize(fruit_type: Enums.Fruit_Type, grabbable_type: Enums.Grabbable_Type, fruit_type2: Enums.Fruit_Type):
	fruit = fruit_type
	grab_type = grabbable_type
	fruit2 = fruit_type2
	#if grab_type == Enums.Grabbable_Type.BLENDED_FRUIT:
		#scale = Vector2(2.0, 2.0)
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							$Sprite2D.texture = Globals.CUP_APPLE_APPLE
						Enums.Fruit_Type.ORANGE:
							$Sprite2D.texture = Globals.CUP_APPLE_ORANGE
						Enums.Fruit_Type.BANANA:
							$Sprite2D.texture = Globals.CUP_APPLE_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							$Sprite2D.texture = Globals.CUP_APPLE_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							$Sprite2D.texture = Globals.CUP_APPLE_PLUM
						Enums.Fruit_Type.NONE:
							$Sprite2D.texture = Globals.CUP_APPLE
					Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							$Sprite2D.texture = Globals.CUP_ORANGE_APPLE
						Enums.Fruit_Type.ORANGE:
							$Sprite2D.texture = Globals.CUP_ORANGE_ORANGE
						Enums.Fruit_Type.BANANA:
							$Sprite2D.texture = Globals.CUP_ORANGE_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							$Sprite2D.texture = Globals.CUP_ORANGE_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							$Sprite2D.texture = Globals.CUP_ORANGE_PLUM
						Enums.Fruit_Type.NONE:
							$Sprite2D.texture = Globals.CUP_ORANGE
					Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							$Sprite2D.texture = Globals.CUP_BANANA_APPLE
						Enums.Fruit_Type.ORANGE:
							$Sprite2D.texture = Globals.CUP_BANANA_ORANGE
						Enums.Fruit_Type.BANANA:
							$Sprite2D.texture = Globals.CUP_BANANA_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							$Sprite2D.texture = Globals.CUP_BANANA_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							$Sprite2D.texture = Globals.CUP_BANANA_PLUM
						Enums.Fruit_Type.NONE:
							$Sprite2D.texture = Globals.CUP_BANANA
					Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.BLUEBERRIES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_BLUEBERRIES
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							$Sprite2D.texture = Globals.CUP_BLUEBERRY_APPLE
						Enums.Fruit_Type.ORANGE:
							$Sprite2D.texture = Globals.CUP_BLUEBERRY_ORANGE
						Enums.Fruit_Type.BANANA:
							$Sprite2D.texture = Globals.CUP_BLUEBERRY_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							$Sprite2D.texture = Globals.CUP_BLUEBERRY_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							$Sprite2D.texture = Globals.CUP_BLUEBERRY_PLUM
						Enums.Fruit_Type.NONE:
							$Sprite2D.texture = Globals.CUP_BLUEBERRY
					Globals.grabbable_sprite = $Sprite2D.texture
		Enums.Fruit_Type.PLUM:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					$Sprite2D.texture = Globals.PLUM
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					$Sprite2D.texture = Globals.CHOPPED_PLUM
					Globals.grabbable_sprite = $Sprite2D.texture
				Enums.Grabbable_Type.BLENDED_FRUIT:
					match fruit2:
						Enums.Fruit_Type.APPLE:
							$Sprite2D.texture = Globals.CUP_PLUM_APPLE
						Enums.Fruit_Type.ORANGE:
							$Sprite2D.texture = Globals.CUP_PLUM_ORANGE
						Enums.Fruit_Type.BANANA:
							$Sprite2D.texture = Globals.CUP_PLUM_BANANA
						Enums.Fruit_Type.BLUEBERRIES:
							$Sprite2D.texture = Globals.CUP_PLUM_BLUEBERRY
						Enums.Fruit_Type.PLUM:
							$Sprite2D.texture = Globals.CUP_PLUM_PLUM
						Enums.Fruit_Type.NONE:
							$Sprite2D.texture = Globals.CUP_PLUM
					Globals.grabbable_sprite = $Sprite2D.texture


func on_grabbable_placed() -> void:
	Globals.is_grabbing = false
	queue_free()
