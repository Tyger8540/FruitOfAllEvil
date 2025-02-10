class_name CharonBoss
extends Boss

@export var customers: Array[Customer]
@export var num_waves: int = 5

var num_customers_spawned: int = 0
var num_customers: int = 6
var customers_spawning: bool = false
var new_wave_queued: bool = false
var cur_wave: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.charon_customer_created.connect(on_customer_created)
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("space"):
		#start_boss_fight()
	if State.boss_queued or new_wave_queued:
		if cur_wave > num_waves:
			new_wave_queued = false
		elif not customers_spawning:
			customers_spawning = true
			var customer_indices: Array[int]
			var possible_indices: Array[int] = [0, 1, 2, 3, 4, 5]
			var index: int
			match cur_wave:
				1:
					num_customers = 2
					for i in range(num_customers):
						index = possible_indices.pick_random()
						possible_indices.erase(index)
						customer_indices.append(index)
				2:
					num_customers = 3
					for i in range(num_customers):
						index = possible_indices.pick_random()
						possible_indices.erase(index)
						customer_indices.append(index)
				3:
					num_customers = 4
					for i in range(num_customers):
						index = possible_indices.pick_random()
						possible_indices.erase(index)
						customer_indices.append(index)
				4:
					num_customers = 5
					for i in range(num_customers):
						index = possible_indices.pick_random()
						possible_indices.erase(index)
						customer_indices.append(index)
				5:
					num_customers = 6
					customer_indices = possible_indices
			
			SignalManager.charon_started.emit(customer_indices)
		elif num_customers_spawned == num_customers:
			State.boss_queued = false
			new_wave_queued = false
			start_boss_fight()


func start_boss_fight() -> void:
	#super()  # Makes sure this is the boss fight that should start
	
	for customer in customers:
		# TODO Make the difficulties and stuff revolve around the wave number
		var rand_difficulty := randi_range(1, 12)
		var customer_sprite: Texture2D
		var i = randi_range(1, 2)
		if i == 1:
			customer_sprite = load("res://final_art/Grotesquelimbo_ok_360.png")  # CHANGE THIS TO BE RANDOM WHEN HAVE MORE CUSTOMER SPRITES
		else:
			customer_sprite = load("res://final_art/Grotesquelimbo_sadge_360.png")
		customer.initialize(customer_sprite, rand_difficulty, 1, 62.0, 0, 0)  # TODO CHANGE FROM ALWAYS 62.0
	SignalManager.boss_fight_started.emit()


func on_customer_created() -> void:
	num_customers_spawned += 1


func reset_customers() -> void:
	num_customers_spawned = 0
	cur_wave += 1
	new_wave_queued = true
