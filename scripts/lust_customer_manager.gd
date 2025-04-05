class_name LustCustomerManager
extends CustomerManager

const LUST_PAIR = preload("res://scenes/lust_pair.tscn")
const LUST_CUSTOMER = preload("res://scenes/lust_customer.tscn")
const MAX_CUSTOMERS = 8

var customer_pairs: Array[LustPair]
var index: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	super(_delta)


func create_customer_pair() -> void:
	# Create a Lust Customer Pair
	var pair = LUST_PAIR.instantiate()
	customer_pairs.append(pair)
	add_child(pair)
	
	# Get the sprites for the pair of customers
	var customer_sprites: Array[Texture2D]
	customer_sprites.append(load("res://final_art/grotesquelimbo_ok_360.png"))  # CHANGE THIS TO BE RANDOM WHEN HAVE MORE CUSTOMER SPRITES
	customer_sprites.append(load("res://final_art/grotesquelimbo_sadge_360.png"))
	
	# Get the stats for the first member of the pair
	var difficulty_level: int = difficulty_queue.pop_front()
	var patience_level: int = patience_queue.pop_front()
	var value: int = value_queue.pop_front()
	
	# Spawn in customer1
	var customer1 = LUST_CUSTOMER.instantiate()
	customer_array.append(customer1)
	pair.add_child(customer1)
	customer1.initialize(customer_sprites[0], difficulty_level, patience_level, 32.0 + 2.0 * difficulty_level, value, customer_array.size() - 1)
	pair.lover1 = customer1
	
	# Get the stats for the second member of the pair
	difficulty_level = difficulty_queue.pop_front()
	patience_level = patience_queue.pop_front()
	value = value_queue.pop_front()
	
	# Spawn in customer2
	var customer2 = LUST_CUSTOMER.instantiate()
	customer_array.append(customer2)
	pair.add_child(customer2)
	customer2.initialize(customer_sprites[1], difficulty_level, patience_level, 32.0 + 2.0 * difficulty_level, value, customer_array.size() - 1)
	pair.lover2 = customer2
	
	# Allow the lovers to see and easily reference each other
	customer1.lover = customer2
	customer2.lover = customer1
	
	# Allow the customers to see the customer manager
	customer1.customer_manager = self
	customer2.customer_manager = self
	
	# Initialize the lust pair
	pair.initialize(index)
	index += 1
	
	# Check if there is room for more customers to spawn in
	if customer_array.size() < MAX_CUSTOMERS and customer_timer.is_stopped() and !difficulty_queue.is_empty():
		customer_timer.start()

func _on_customer_timer_timeout() -> void:
	create_customer_pair()
