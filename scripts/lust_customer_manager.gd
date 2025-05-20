class_name LustCustomerManager
extends CustomerManager

const LUST_PAIR = preload("res://scenes/lust_pair.tscn")
const LUST_CUSTOMER = preload("res://scenes/lust_customer.tscn")
const MAX_CUSTOMERS = 8

@export var female_sprites: Array[Texture2D]
@export var male_sprites: Array[Texture2D]
@export var female_dancing_sprite: Texture2D
@export var male_dancing_sprite: Texture2D

var customer_pairs: Array[LustPair]
#var index: int = 0

var pair_positions: Array[Vector2]

var spawnpoint_filled: Array[bool] = [false, false, false, false]

var started_swapping: bool = false

@onready var left_area: Area2D = %LeftArea
@onready var right_area: Area2D = %RightArea
@onready var upper_area: Area2D = %UpperArea
@onready var swap_timer: Timer = $SwapTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Starts the swapping customer mechanic on wave 3
	if not started_swapping and %WaveManager.cur_wave == 3:
		started_swapping = true
		swap_customer_pairs()
		swap_timer.start(randf_range(2.5, 5.0))  # Arbitrary values for swapping interval'
	# Starts dancing mechanic on wave 2
	if %WaveManager.cur_wave >= 2:
		for pair in customer_pairs:
			if not pair.dancing:
				pair.dancing = true
				pair.dance_timer.start(randf_range(5.0, 15.0))
	super(_delta)


func create_customer_pair() -> void:
	# Create a Lust Customer Pair
	var pair = LUST_PAIR.instantiate()
	customer_pairs.append(pair)
	add_child(pair)
	
	# Get the sprites for the pair of customers
	var customer_sprites: Array[Texture2D]
	customer_sprites.append(female_sprites.pick_random())
	customer_sprites.append(male_sprites.pick_random())
	
	# Get the stats for the first member of the pair
	var difficulty_level: int = difficulty_queue.pop_front()
	var patience_level: int = patience_queue.pop_front()
	var value: int = value_queue.pop_front()
	
	# Spawn in customer1
	var customer1 = LUST_CUSTOMER.instantiate()
	customer_array.append(customer1)
	pair.add_child(customer1)
	customer1.initialize(customer_sprites[0], difficulty_level, patience_level, 16.0 + 2.0 * difficulty_level, value, customer_array.size() - 1)
	customer1.dancing_texture = female_dancing_sprite
	pair.lover1 = customer1
	
	# Get the stats for the second member of the pair
	difficulty_level = difficulty_queue.pop_front()
	patience_level = patience_queue.pop_front()
	value = value_queue.pop_front()
	
	# Spawn in customer2
	var customer2 = LUST_CUSTOMER.instantiate()
	customer_array.append(customer2)
	pair.add_child(customer2)
	customer2.initialize(customer_sprites[1], difficulty_level, patience_level, 16.0 + 2.0 * difficulty_level, value, customer_array.size() - 1)
	customer2.dancing_texture = male_dancing_sprite
	pair.lover2 = customer2
	
	# Allow the lovers to see and easily reference each other
	customer1.lover = customer2
	customer2.lover = customer1
	
	# Allow the customers to see the customer manager
	customer1.customer_manager = self
	customer2.customer_manager = self
	
	# Initialize the lust pair
	pair.initialize(customer_pairs)
	#index += 1
	
	# Check if there is room for more customers to spawn in
	if customer_array.size() < MAX_CUSTOMERS and customer_timer.is_stopped() and !difficulty_queue.is_empty():
		customer_timer.start()


func create_customer_queue(difficulty_array: Array[int], patience_array: Array[int], value_array: Array[int], waiting_time: float) -> void:
	super(difficulty_array, patience_array, value_array, waiting_time)


func on_customer_left(index: int) -> void:
	if customer_timer.is_stopped() and !difficulty_queue.is_empty():
		customer_timer.start()


func swap_customer_pairs() -> void:
	if customer_pairs.size() < 2:
		return
	
	# Pick two of the current customer pairs
	var pair1 = customer_pairs.pick_random()
	var pair2 = customer_pairs.pick_random()
	while pair1 == pair2:
		pair2 = customer_pairs.pick_random()
	
	# Get the current (target) positions of the two lust pairs
	var pos1: Vector2 = pair1.target_position
	var pos2: Vector2 = pair2.target_position
	
	# Get the spawnpoint indices of the two lust pairs
	var index1 = pair1.spawnpoint_index
	var index2 = pair2.spawnpoint_index
	
	# Set new values for lust pair 1
	pair1.target_position = pos2
	pair1.spawnpoint_index = index2
	
	# Set new values for lust pair 2
	pair2.target_position = pos1
	pair2.spawnpoint_index = index1


func _on_customer_timer_timeout() -> void:
	create_customer_pair()


func _on_swap_timer_timeout() -> void:
	swap_customer_pairs()
	swap_timer.start(randf_range(5.0, 15.0))
