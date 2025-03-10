extends Node

const APPLE = preload("res://final_art/Apple.png")
const CHOPPED_APPLE = preload("res://final_art/Apple_Chopped.png")
const BLENDED_APPLE = preload("res://placeholder_art/Apple3.png")

const ORANGE = preload("res://final_art/Orange.png")
const CHOPPED_ORANGE = preload("res://final_art/Orange_Chopped.png")
const BLENDED_ORANGE = preload("res://placeholder_art/Orange3.png")

const BANANA = preload("res://final_art/Banana.png")
const CHOPPED_BANANA = preload("res://final_art/Banana_Chopped.png")
const BLENDED_BANANA = preload("res://placeholder_art/BlendedBanana.png")

const BLUEBERRIES = preload("res://final_art/Blueberry.png")
const CHOPPED_BLUEBERRIES = preload("res://final_art/Blueberry_Chopped.png")
const BLENDED_BLUEBERRIES = preload("res://placeholder_art/BlendedBlueberries.png")

const PLUM = preload("res://final_art/Grape.png")
const CHOPPED_PLUM = preload("res://final_art/Grape_Chopped.png")
const BLENDED_PLUM = preload("res://placeholder_art/BlendedPlum.png")

const BLENDER_APPLE_APPLE = preload("res://art/fruit/blender_combinations/Blender Apple Apple.png")
const BLENDER_APPLE_BANANA = preload("res://art/fruit/blender_combinations/Blender Apple Banana.png")
const BLENDER_APPLE_BLUEBERRY = preload("res://art/fruit/blender_combinations/Blender Apple Blueberry.png")
const BLENDER_APPLE_ORANGE = preload("res://art/fruit/blender_combinations/Blender Apple Orange.png")
const BLENDER_APPLE_PLUM = preload("res://art/fruit/blender_combinations/Blender Apple Plum.png")
const BLENDER_APPLE = preload("res://art/fruit/blender_combinations/Blender Apple.png")
const BLENDER_BANANA_APPLE = preload("res://art/fruit/blender_combinations/Blender Banana Apple.png")
const BLENDER_BANANA_BANANA = preload("res://art/fruit/blender_combinations/Blender Banana Banana.png")
const BLENDER_BANANA_BLUEBERRY = preload("res://art/fruit/blender_combinations/Blender Banana Blueberry.png")
const BLENDER_BANANA_ORANGE = preload("res://art/fruit/blender_combinations/Blender Banana Orange.png")
const BLENDER_BANANA_PLUM = preload("res://art/fruit/blender_combinations/Blender Banana Plum.png")
const BLENDER_BANANA = preload("res://art/fruit/blender_combinations/Blender Banana.png")
const BLENDER_BLUEBERRY_APPLE = preload("res://art/fruit/blender_combinations/Blender Blueberry Apple.png")
const BLENDER_BLUEBERRY_BANANA = preload("res://art/fruit/blender_combinations/Blender Blueberry Banana.png")
const BLENDER_BLUEBERRY_BLUEBERRY = preload("res://art/fruit/blender_combinations/Blender Blueberry Blueberry.png")
const BLENDER_BLUEBERRY_ORANGE = preload("res://art/fruit/blender_combinations/Blender Blueberry Orange.png")
const BLENDER_BLUEBERRY_PLUM = preload("res://art/fruit/blender_combinations/Blender Blueberry Plum.png")
const BLENDER_BLUEBERRY = preload("res://art/fruit/blender_combinations/Blender Blueberry.png")
const BLENDER_ORANGE_APPLE = preload("res://art/fruit/blender_combinations/Blender Orange Apple.png")
const BLENDER_ORANGE_BANANA = preload("res://art/fruit/blender_combinations/Blender Orange Banana.png")
const BLENDER_ORANGE_BLUEBERRY = preload("res://art/fruit/blender_combinations/Blender Orange Blueberry.png")
const BLENDER_ORANGE_ORANGE = preload("res://art/fruit/blender_combinations/Blender Orange Orange.png")
const BLENDER_ORANGE_PLUM = preload("res://art/fruit/blender_combinations/Blender Orange Plum.png")
const BLENDER_ORANGE = preload("res://art/fruit/blender_combinations/Blender Orange.png")
const BLENDER_PLUM_APPLE = preload("res://art/fruit/blender_combinations/Blender Plum Apple.png")
const BLENDER_PLUM_BANANA = preload("res://art/fruit/blender_combinations/Blender Plum Banana.png")
const BLENDER_PLUM_BLUEBERRY = preload("res://art/fruit/blender_combinations/Blender Plum Blueberry.png")
const BLENDER_PLUM_ORANGE = preload("res://art/fruit/blender_combinations/Blender Plum Orange.png")
const BLENDER_PLUM_PLUM = preload("res://art/fruit/blender_combinations/Blender Plum Plum.png")
const BLENDER_PLUM = preload("res://art/fruit/blender_combinations/Blender Plum.png")

const CUP_APPLE_APPLE = preload("res://art/fruit/cup_combinations/Cup Apple Apple.png")
const CUP_APPLE_BANANA = preload("res://art/fruit/cup_combinations/Cup Apple Banana.png")
const CUP_APPLE_BLUEBERRY = preload("res://art/fruit/cup_combinations/Cup Apple Blueberry.png")
const CUP_APPLE_ORANGE = preload("res://art/fruit/cup_combinations/Cup Apple Orange.png")
const CUP_APPLE_PLUM = preload("res://art/fruit/cup_combinations/Cup Apple Plum.png")
const CUP_APPLE = preload("res://art/fruit/cup_combinations/Cup Apple.png")
const CUP_BANANA_APPLE = preload("res://art/fruit/cup_combinations/Cup Banana Apple.png")
const CUP_BANANA_BANANA = preload("res://art/fruit/cup_combinations/Cup Banana Banana.png")
const CUP_BANANA_BLUEBERRY = preload("res://art/fruit/cup_combinations/Cup Banana Blueberry.png")
const CUP_BANANA_ORANGE = preload("res://art/fruit/cup_combinations/Cup Banana Orange.png")
const CUP_BANANA_PLUM = preload("res://art/fruit/cup_combinations/Cup Banana Plum.png")
const CUP_BANANA = preload("res://art/fruit/cup_combinations/Cup Banana.png")
const CUP_BLUEBERRY_APPLE = preload("res://art/fruit/cup_combinations/Cup Blueberry Apple.png")
const CUP_BLUEBERRY_BANANA = preload("res://art/fruit/cup_combinations/Cup Blueberry Banana.png")
const CUP_BLUEBERRY_BLUEBERRY = preload("res://art/fruit/cup_combinations/Cup Blueberry Blueberry.png")
const CUP_BLUEBERRY_ORANGE = preload("res://art/fruit/cup_combinations/Cup Blueberry Orange.png")
const CUP_BLUEBERRY_PLUM = preload("res://art/fruit/cup_combinations/Cup Blueberry Plum.png")
const CUP_BLUEBERRY = preload("res://art/fruit/cup_combinations/Cup Blueberry.png")
const CUP_ORANGE_APPLE = preload("res://art/fruit/cup_combinations/Cup Orange Apple.png")
const CUP_ORANGE_BANANA = preload("res://art/fruit/cup_combinations/Cup Orange Banana.png")
const CUP_ORANGE_BLUEBERRY = preload("res://art/fruit/cup_combinations/Cup Orange Blueberry.png")
const CUP_ORANGE_ORANGE = preload("res://art/fruit/cup_combinations/Cup Orange Orange.png")
const CUP_ORANGE_PLUM = preload("res://art/fruit/cup_combinations/Cup Orange Plum.png")
const CUP_ORANGE = preload("res://art/fruit/cup_combinations/Cup Orange.png")
const CUP_PLUM_APPLE = preload("res://art/fruit/cup_combinations/Cup Plum Apple.png")
const CUP_PLUM_BANANA = preload("res://art/fruit/cup_combinations/Cup Plum Banana.png")
const CUP_PLUM_BLUEBERRY = preload("res://art/fruit/cup_combinations/Cup Plum Blueberry.png")
const CUP_PLUM_ORANGE = preload("res://art/fruit/cup_combinations/Cup Plum Orange.png")
const CUP_PLUM_PLUM = preload("res://art/fruit/cup_combinations/Cup Plum Plum.png")
const CUP_PLUM = preload("res://art/fruit/cup_combinations/Cup Plum.png")

var is_grabbing:= false
var grabbable_sprite: CompressedTexture2D
var grabbable_fruit_type: Array[Enums.Fruit_Type]
var grabbable_grab_type:= Enums.Grabbable_Type.NONE

var money:= 0

var upgrade_level = {Enums.Upgrade_Type.MORE_PATIENCE: 0, Enums.Upgrade_Type.CHOPPING_BOARD: 0, Enums.Upgrade_Type.CHOP_SPEED: 0, Enums.Upgrade_Type.BLENDER: 0, Enums.Upgrade_Type.BLEND_SPEED: 0}

const VIRGIL_TEST_512 = preload("res://final_art/Virgil_Test_512.png")
const OVID_512 = preload("res://final_art/Ovid_512.png")

var vendor_sprites: Dictionary = {
	"Virgil": VIRGIL_TEST_512,
	"Ovid": OVID_512,
}
