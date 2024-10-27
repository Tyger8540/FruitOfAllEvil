class_name CustomerManager
extends Node2D

const CUSTOMER_SCENE = preload("res://scenes/customer.tscn")

var customer_array: Array[Customer]
var difficulty_queue: Array[int]
var patience_queue: Array[int]

@onready var customer_timer: Timer = $CustomerTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.customer_left.connect(on_customer_left)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func create_customer(difficulty_level: int, patience_level: int) -> void:
	var customer = CUSTOMER_SCENE.instantiate()
	var customer_sprite: Texture2D
	var i = randi_range(1, 2)
	if i == 1:
		customer_sprite = load("res://art/customers/Demon.png")  # CHANGE THIS TO BE RANDOM WHEN HAVE MORE CUSTOMER SPRITES
	else:
		customer_sprite = load("res://art/customers/mehDemon2.png")
	customer_array.append(customer)
	add_child(customer)
	customer.initialize(customer_sprite, difficulty_level, customer_array.size() - 1)
	if customer_array.size() <= 4 and customer_timer.is_stopped():
		customer_timer.start()


func create_customer_queue(difficulty_array: Array[int], patience_array: Array[int]) -> void:
	difficulty_queue = difficulty_array
	patience_queue = patience_array


func on_customer_left(index: int) -> void:
	customer_array.pop_at(index)
	if customer_timer.is_stopped():
		customer_timer.start()


func _on_customer_timer_timeout() -> void:
	create_customer(difficulty_queue.pop_front(), patience_queue.pop_front())
