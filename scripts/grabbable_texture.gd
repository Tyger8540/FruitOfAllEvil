class_name GrabbableTexture
extends TextureRect

@export var top_blended_fruit: TextureRect
@export var bottom_blended_fruit: TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func initialize(fruit1: Enums.Fruit_Type, grab_type: Enums.Grabbable_Type, fruit2: Enums.Fruit_Type) -> void:
	print("fruit: " + str(fruit1) + ", grab_type: " + str(grab_type) + ", fruit2: " + str(fruit2))
	if grab_type == Enums.Grabbable_Type.BLENDED_FRUIT:
		texture = Globals.BLENDED_CUP
		bottom_blended_fruit.texture = get_fruit_texture(fruit1, grab_type)
		if not fruit2 == Enums.Fruit_Type.NONE:
			top_blended_fruit.texture = get_fruit_texture(fruit2, grab_type)
	else:
		texture = get_fruit_texture(fruit1, grab_type)
	# NOTE THIS WILL BE EXPANDED FOR FUTURE APPLIANCES!!!


func get_fruit_texture(fruit: Enums.Fruit_Type, grab_type: Enums.Grabbable_Type) -> Texture2D:
	match fruit:
		Enums.Fruit_Type.APPLE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.APPLE
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_APPLE
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.CUP_APPLE2  # TODO MAKE THIS NOT HAVE A 2
		Enums.Fruit_Type.ORANGE:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.ORANGE
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_ORANGE
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.CUP_ORANGE2
		Enums.Fruit_Type.BANANA:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.BANANA
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_BANANA
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.CUP_BANANA2
		Enums.Fruit_Type.BLUEBERRIES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.BLUEBERRIES
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_BLUEBERRIES
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.CUP_BLUEBERRIES
		Enums.Fruit_Type.GRAPES:
			match grab_type:
				Enums.Grabbable_Type.FRUIT:
					return Globals.GRAPES
				Enums.Grabbable_Type.CHOPPED_FRUIT:
					return Globals.CHOPPED_GRAPES
				Enums.Grabbable_Type.BLENDED_FRUIT:
					return Globals.CUP_GRAPES
	print("null random texture")
	return null


func set_grabbable_texture(grab_texture: GrabbableTexture) -> void: 
	texture = grab_texture.texture
	bottom_blended_fruit.texture = grab_texture.bottom_blended_fruit.texture
	top_blended_fruit.texture = grab_texture.top_blended_fruit.texture
