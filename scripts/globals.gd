extends Node


const APPLE = preload("res://art/fruit/Apple.png")
const CHOPPED_APPLE = preload("res://art/fruit/AppleSlices.png")
const BLENDED_APPLE = preload("res://placeholder_art/Apple3.png")

const ORANGE = preload("res://art/fruit/Orange.png")
const CHOPPED_ORANGE = preload("res://art/fruit/OrangeSlices.png")
const BLENDED_ORANGE = preload("res://placeholder_art/Orange3.png")

const BANANA = preload("res://art/fruit/Banana.png")
const CHOPPED_BANANA = preload("res://art/fruit/BananaSlices.png")
const BLENDED_BANANA = preload("res://placeholder_art/BlendedBanana.png")

const BLUEBERRIES = preload("res://art/fruit/Blueberries.png")
const CHOPPED_BLUEBERRIES = preload("res://art/fruit/BlueberrySlices.png")
const BLENDED_BLUEBERRIES = preload("res://placeholder_art/BlendedBlueberries.png")

const PLUM = preload("res://art/fruit/Plum.png")
const CHOPPED_PLUM = preload("res://art/fruit/PlumSlices.png")
const BLENDED_PLUM = preload("res://placeholder_art/BlendedPlum.png")

var is_grabbing:= false
var grabbable_sprite: CompressedTexture2D
var grabbable_fruit_type: Enums.Fruit_Type
var grabbable_grab_type: Enums.Grabbable_Type

var money:= 500

var upgrade_level = {Enums.Upgrade_Type.MORE_PATIENCE: 0, Enums.Upgrade_Type.CHOPPING_BOARD: 0, Enums.Upgrade_Type.CHOP_SPEED: 0, Enums.Upgrade_Type.BLENDER: 0, Enums.Upgrade_Type.BLEND_SPEED: 0}
