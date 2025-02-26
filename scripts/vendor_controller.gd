class_name VendorController
extends Node2D

const VENDOR = preload("res://scenes/vendor.tscn")

var circle_num: int
var vendors_spawned: bool = false
var vendors_spawning: bool = false
var num_vendors: int

var vendor_names: Array[String]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle_num = State.circle_num


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not vendors_spawned and not vendors_spawning:
		vendors_spawning = true
		spawn_vendors()


func create_vendor(vendor_name, vendor_index) -> void:
	vendor_names.append(vendor_name)
	var vendor = VENDOR.instantiate()
	add_child(vendor)
	vendor.initialize(vendor_name, vendor_index)


func spawn_vendors() -> void:
	match circle_num:
		0:
			create_vendor("Virgil", 0)
			num_vendors = 1
		1:
			create_vendor("Virgil", 0)
			create_vendor("Ovid", 1)
			num_vendors = 2
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass
		6:
			pass
		7:
			pass
		8:
			pass
		9:
			pass
	vendors_spawned = true
	vendors_spawning = false
	%FarmersMarketCamera.update_num_vendors(num_vendors)
