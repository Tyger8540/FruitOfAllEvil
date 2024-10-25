class_name CustomerManager
extends Node2D

const CUSTOMER_SCENE = preload("res://scenes/customer.tscn")

@onready var customer_timer: Timer = $CustomerTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.new_customer_spawned.connect(on_new_customer_spawned)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func create_customer() -> void:
	var customer = CUSTOMER_SCENE.instantiate()
	var customer_sprite: Texture2D
	customer_sprite = load("res://art/customers/Demon.png")  # CHANGE THIS TO BE RANDOM WHEN HAVE MORE CUSTOMER SPRITES
	var difficulty_level: int
	difficulty_level = 0  # CHANGE THIS TO BE SOMEWHAT RANDOM (BASED ON ROUND)
	add_child(customer)
	customer.initialize(customer_sprite, difficulty_level)
	pass


func _on_customer_timer_timeout() -> void:
	create_customer()


func on_new_customer_spawned() -> void:
	customer_timer.start()
