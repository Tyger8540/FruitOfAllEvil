class_name Vendor
extends Node2D

@export var vendor_name: String
@export var vendor_index: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func initialize(_vendor_name, _vendor_index) -> void:
	vendor_name = _vendor_name
	$Sprite2D.texture = Globals.vendor_sprites[vendor_name]
	vendor_index = _vendor_index
	position = Vector2(vendor_index * 1920.0, -1080.0)
