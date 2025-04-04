class_name CharonBoss
extends Boss

@export var customers: Array[Customer]
@export var num_waves: int = 3
@export var charon_path: PathFollow2D

var num_customers_spawned: int = 0
var num_customers: int = 6
var customers_spawning: bool = false
var new_wave_queued: bool = false
var cur_wave: int = 1
var wave_in_progress: bool = false

var talking: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.charon_customer_created.connect(on_customer_created)
	SignalManager.charon_customer_finished.connect(on_customer_finished)
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wave_in_progress and customers.size() == 0:
		wave_in_progress = false
		if charon_path.moving_in or charon_path.paused_on_screen:
			talk(State.dialogue_file, "C1_level_charon_barks_complete", 2.5)
			charon_path.start_on_screen_timer(5.0)
			%WaveIntermissionTimer.start(10.0)
		else:
			%WaveIntermissionTimer.start(5.0)
	
	if State.boss_queued or new_wave_queued:
		# A new boss wave is queued, whether the first wave or a later wave
		if cur_wave > num_waves:
			# Defeated the last wave
			new_wave_queued = false
			State.dialogue_ready = true
		elif not customers_spawning:
			# Customers have not started spawning, need to start doing that
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
					num_customers = 4
					for i in range(num_customers):
						index = possible_indices.pick_random()
						possible_indices.erase(index)
						customer_indices.append(index)
				3:
					num_customers = 6
					customer_indices = possible_indices
			
			SignalManager.charon_started.emit(customer_indices)
		elif num_customers_spawned == num_customers:
			# Customers have finished spawning, time to start the boss fight
			State.boss_queued = false
			new_wave_queued = false
			customers_spawning = false
			start_boss_fight()


func start_boss_fight() -> void:
	super()  # Makes sure this is the boss fight that should start
	
	for customer in customers:
		var rand_difficulty: int
		var difficulty_pool: Array[int]
		match cur_wave:
			1:
				difficulty_pool = [1, 2, 3, 4, 5, 6]
			2:
				difficulty_pool = [4, 5, 6, 7, 8, 9]
			3:
				difficulty_pool = [7, 8, 9, 10, 11, 12]
		rand_difficulty = difficulty_pool.pick_random()
		var customer_sprite: Texture2D
		var i = randi_range(1, 2)
		if i == 1:
			customer_sprite = load("res://final_art/grotesquelimbo_ok_360.png")  # CHANGE THIS TO BE RANDOM WHEN HAVE MORE CUSTOMER SPRITES
		else:
			customer_sprite = load("res://final_art/grotesquelimbo_sadge_360.png")
		var rand_time: float = 30.0 + rand_difficulty * 3.0
		customer.initialize(customer_sprite, rand_difficulty, 1, rand_time, 0, 0)  # TODO MAKE BETTER RAND TIME SYSTEM MAYBE
	wave_in_progress = true
	SignalManager.boss_fight_started.emit()
	talk(State.dialogue_file, "C1_level_charon_barks_new", 5.0)
	talking = true
	AudioManager.play_sound(self, "res://audio/sfx/water_splash.wav", Enums.Audio_Type.SFX)


func on_customer_created() -> void:
	num_customers_spawned += 1


func on_customer_finished(customer: Customer) -> void:
	customers.erase(customer)
	#customer.queue_free()


func reset_customers() -> void:
	num_customers_spawned = 0
	cur_wave += 1
	new_wave_queued = true


func _on_wave_intermission_timer_timeout() -> void:
	reset_customers()
