extends PathFollow2D

@export var is_charon: bool
@export var is_actually_charon: bool
@export var customer_index: int
@export var customer_position: Vector2
@export var charon: CharonBoss

const CHARON_CUSTOMER_SCENE = preload("res://scenes/charon_customer.tscn")

var speed := 0.2
var paused_on_screen := false
var paused_off_screen := true
var moving_in := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.charon_on_screen_timer_ended.connect(on_screen_timeout)
	SignalManager.charon_off_screen_timer_ended.connect(off_screen_timeout)
	SignalManager.charon_started.connect(create_customer)
	SignalManager.boss_fight_started.connect(on_boss_fight_started)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("space"):
		#moving_in = true
		#progress_ratio = 0.0
		#paused_off_screen = false
	
	if moving_in and progress_ratio >= 0.499:
		progress_ratio = 0.5
		moving_in = false
		paused_on_screen = true
		if is_charon:
			%OnScreenTimer.start(randf_range(15.0, 25.0))
		if is_actually_charon:
			if not charon.talking:
				charon.talk(State.dialogue_file, "C1_level_charon_barks_arrive", 5.0)
			else:
				charon.talking = false
	elif not moving_in and progress_ratio >= 0.999 and not paused_off_screen:
		paused_off_screen = true
		if is_charon:
			if charon.wave_in_progress:
				# Only wait off screen if the wave is still in progress
				%OffScreenTimer.start(randf_range(5.0, 15.0))
	elif paused_off_screen and not is_charon and get_child_count() > 0 and not get_child(0) in charon.customers:
		get_child(0).queue_free()
	
	if not paused_on_screen and not paused_off_screen:
		loop_movement(delta)


func loop_movement(delta):
	progress_ratio += delta * speed


func on_screen_timeout() -> void:
	if charon.wave_in_progress and not charon.talking:
		if not is_actually_charon:
			start_on_screen_timer(5.0)
			return
		else:
			charon.talking = true
			start_on_screen_timer(5.0)
			charon.talk(State.dialogue_file, "C1_level_charon_barks_depart", 2.5)
			AudioManager.play_sound(self, "res://audio/sfx/warning (4).wav", Enums.Audio_Type.SFX)
			return
	
	if is_actually_charon:
		charon.talking = false
		AudioManager.play_sound(self, "res://audio/sfx/water_splash.wav", Enums.Audio_Type.SFX)
	paused_on_screen = false


func off_screen_timeout() -> void:
	paused_off_screen = false
	progress_ratio = 0.0
	moving_in = true
	if is_actually_charon:
		AudioManager.play_sound(self, "res://audio/sfx/water_splash.wav", Enums.Audio_Type.SFX)


func create_customer(customer_indices: Array[int]) -> void:
	if is_charon:
		return
	
	# Creates a customer at this path
	if customer_index in customer_indices:
		var customer = CHARON_CUSTOMER_SCENE.instantiate()
		customer.position = customer_position
		add_child(customer)
		charon.customers.append(customer)
		SignalManager.charon_customer_created.emit()


func on_boss_fight_started() -> void:
	moving_in = true
	progress_ratio = 0.0
	paused_off_screen = false


func start_on_screen_timer(time: float) -> void:
	%OnScreenTimer.start(time)


func _on_on_screen_timer_timeout() -> void:
	if is_charon:
		SignalManager.charon_on_screen_timer_ended.emit()


func _on_off_screen_timer_timeout() -> void:
	if is_charon:
		SignalManager.charon_off_screen_timer_ended.emit()
