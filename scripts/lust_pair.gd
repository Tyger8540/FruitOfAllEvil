class_name LustPair
extends CharacterBody2D

const LOVER_OFFSET = 68.0

const SPEED = 450.0

const LEFT_BOUND = -800.0
const RIGHT_BOUND = 800.0
const UPPER_BOUND = 70.0
const LOWER_BOUND = 220.0
const PAIR_X_DISTANCE = 280.0

const LEFT_SPAWNPOINT = -600.0
const CENTER_LEFT_SPAWNPOINT = -200.0
const CENTER_RIGHT_SPAWNPOINT = 200.0
const RIGHT_SPAWNPOINT = 600.0
const SPAWNPOINT_RANGE = 50.0

@export var lover1: LustCustomer
@export var lover2: LustCustomer

var target_position: Vector2
var initialized: bool = false
var started_timer: bool = false

var spawnpoint_index: int

var dancing: bool = false

@onready var green_patience_bar: TextureProgressBar = $GreenPatienceBar
@onready var red_patience_bar: TextureProgressBar = $RedPatienceBar

@onready var green_patience_timer: Timer = $GreenPatienceTimer
@onready var red_patience_timer: Timer = $RedPatienceTimer

@onready var dance_timer: Timer = $DanceTimer
@onready var dance_intermission_timer: Timer = $DanceIntermissionTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if green_patience_bar.visible and green_patience_bar.value > 0 and !green_patience_timer.is_stopped():
		green_patience_bar.value = green_patience_timer.time_left
	elif !red_patience_timer.is_stopped():
		red_patience_bar.value = red_patience_timer.time_left
	
	if position.distance_to(target_position) >= 0.1:
		position = position.move_toward(target_position, SPEED * delta)
	else:
		# set the order panel once the customer reaches their stand_position, if panel not already visible
		#if !panel.visible:
			#panel.visible = true
		if not started_timer:
			green_patience_bar.visible = true
			red_patience_bar.visible = true
			lover1.panel.visible = true
			lover2.panel.visible = true
			green_patience_timer.start()
			started_timer = true
			lover1.check_hovering()
			lover2.check_hovering()
	
	#if not dancing and %WaveManager.cur_wave >= 2:
		#dancing = true
		#dance_timer.start(randf_range(5.0, 15.0))
	
	move_and_slide()


func initialize(customer_pairs: Array[LustPair]) -> void:
	# Make the pair spawn outside the bounds of the screen, then make their way in
	# to simulate people making their way to the ballroom
	#position = Vector2(-800.0 + 300.0 * index, 70.0)
	generate_spawn_position()
	generate_target_position(customer_pairs)
	#lover1.position.x -= LOVER_OFFSET
	lover1.customer_button.position.x -= lover1.customer_button.size.x
	#lover2.position.x += LOVER_OFFSET
	set_patience_timers()
	#green_patience_timer.start()
	initialized = true


func set_patience_timers() -> void:
	green_patience_timer.wait_time = lover1.green_patience_timer.wait_time + lover2.green_patience_timer.wait_time
	green_patience_bar.max_value = green_patience_timer.wait_time
	red_patience_timer.wait_time = 2 * green_patience_timer.wait_time
	red_patience_bar.max_value = red_patience_timer.wait_time
	red_patience_bar.value = red_patience_bar.max_value


func dance() -> void:
	var dance_rand = randi_range(0, 1)
	match dance_rand:
		0:
			lover1.set_sprite(lover1.dancing_near_texture)
			lover2.set_sprite(lover2.dancing_far_texture)
			lover1.dancing_near = true
		1:
			lover1.set_sprite(lover1.dancing_far_texture)
			lover2.set_sprite(lover2.dancing_near_texture)
			lover2.dancing_near = true
	var customer_button_distance = absf(lover1.customer_button.position.x - lover2.customer_button.position.x)
	var customer_button_position_1 = lover1.customer_button.position.x
	var customer_button_position_2 = lover2.customer_button.position.x
	lover1.customer_button.position.x = 0.0 - customer_button_distance / 2
	lover2.customer_button.position.x = 0.0 - customer_button_distance / 2
	lover1.customer_button.visible = lover1.dancing_near  # Sets the panel to visible/invisible based on if near
	lover2.customer_button.visible = lover2.dancing_near  # Sets the panel to visible/invisible based on if near
	dance_intermission_timer.start()
	await dance_intermission_timer.timeout
	lover1.dancing_near = false
	lover2.dancing_near = false
	lover1.set_sprite(lover1.default_texture)
	lover2.set_sprite(lover2.default_texture)
	lover1.customer_button.visible = true
	lover2.customer_button.visible = true
	lover1.customer_button.position.x = customer_button_position_2
	lover2.customer_button.position.x = customer_button_position_1
	lover1.invert_sprite_scale()
	lover2.invert_sprite_scale()
	dance_timer.start(randf_range(5.0, 15.0))


func generate_spawn_position() -> void:
	var area: Area2D
	var x = randi_range(0, 2)
	match x:
		0:
			area = get_parent().left_area
		1:
			area = get_parent().right_area
		2:
			area = get_parent().upper_area
	
	var size_x = area.get_child(0).shape.size.x
	var pos_x = randf_range(area.position.x - (size_x / 2), area.position.x + (size_x / 2))
	
	var size_y = area.get_child(0).shape.size.y
	var pos_y = randf_range(area.position.y - (size_y / 2), area.position.y + (size_y / 2))
	
	position = Vector2(pos_x, pos_y)


func generate_target_position(customer_pairs: Array[LustPair]) -> void:
	# Get the indices of available target areas
	var index: int = 0
	var available_spawnpoints: Array[int]
	for filled in get_parent().spawnpoint_filled:
		if not filled:
			available_spawnpoints.append(index)
		index += 1
	
	spawnpoint_index = available_spawnpoints.pick_random()  # set the spawnpoint index
	get_parent().spawnpoint_filled[spawnpoint_index] = true  # fill the spawnpoint
	
	# Spread out customer pairs to ensure no overlapping
	var x_pos: float
	var y_pos: float
	if customer_pairs.size() == 0:
		var left_bound: float
		var right_bound: float
		match spawnpoint_index:
			0:
				left_bound = LEFT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = LEFT_SPAWNPOINT + SPAWNPOINT_RANGE
			1:
				left_bound = CENTER_LEFT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = CENTER_LEFT_SPAWNPOINT + SPAWNPOINT_RANGE
			2:
				left_bound = CENTER_RIGHT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = CENTER_RIGHT_SPAWNPOINT + SPAWNPOINT_RANGE
			3:
				left_bound = RIGHT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = RIGHT_SPAWNPOINT + SPAWNPOINT_RANGE
		x_pos = randf_range(left_bound, right_bound)
		y_pos = randf_range(UPPER_BOUND, LOWER_BOUND)
		target_position = Vector2(x_pos, y_pos)
		print("first x pos: " + str(position.x))
	else:
		#var valid_pos = false
		#while not valid_pos:
			#x_pos = randf_range(LEFT_BOUND, RIGHT_BOUND)
			#y_pos = randf_range(UPPER_BOUND, LOWER_BOUND)
			#for pair in customer_pairs:
				#if pair.target_position.x - PAIR_X_DISTANCE >= x_pos or pair.target_position.x + PAIR_X_DISTANCE <= x_pos:
					#valid_pos = true
				#else:
					#valid_pos = false
					#print("invalid x pos: " + str(x_pos))
					#break
		var left_bound: float
		var right_bound: float
		match spawnpoint_index:
			0:
				left_bound = LEFT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = LEFT_SPAWNPOINT + SPAWNPOINT_RANGE
			1:
				left_bound = CENTER_LEFT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = CENTER_LEFT_SPAWNPOINT + SPAWNPOINT_RANGE
			2:
				left_bound = CENTER_RIGHT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = CENTER_RIGHT_SPAWNPOINT + SPAWNPOINT_RANGE
			3:
				left_bound = RIGHT_SPAWNPOINT - SPAWNPOINT_RANGE
				right_bound = RIGHT_SPAWNPOINT + SPAWNPOINT_RANGE
		x_pos = randf_range(left_bound, right_bound)
		y_pos = randf_range(UPPER_BOUND, LOWER_BOUND)
		target_position = Vector2(x_pos, y_pos)
		print("valid x pos: " + str(x_pos))
	#for pair in customer_pairs:
		#if i == 0:
			#x_pos = randf_range(LEFT_BOUND, RIGHT_BOUND)
			#y_pos = randf_range(UPPER_BOUND, LOWER_BOUND)
			#pair_positions.append(Vector2(x_pos, y_pos))
			#print("first x pos: " + str(x_pos))
		#else:
			#var valid_pos = false
			#while not valid_pos:
				#x_pos = randf_range(LEFT_BOUND, RIGHT_BOUND)
				#y_pos = randf_range(UPPER_BOUND, LOWER_BOUND)
				#for pos in pair_positions:
					#if pos.x - PAIR_X_DISTANCE >= x_pos or pos.x + PAIR_X_DISTANCE <= x_pos:
						#valid_pos = true
					#else:
						#valid_pos = false
						#print("invalid x pos: " + str(x_pos))
						#break
			#pair_positions.append(Vector2(x_pos, y_pos))
			#print("valid x pos: " + str(x_pos))


func speed_up_patience_timers() -> void:
	var temp_green_wait_time = green_patience_timer.wait_time
	var temp_red_wait_time = red_patience_timer.wait_time
	if lover1.is_completed:
		green_patience_timer.wait_time = lover2.green_patience_timer.wait_time
	elif lover2.is_completed:
		green_patience_timer.wait_time = lover1.green_patience_timer.wait_time
	else:
		return
	
	red_patience_timer.wait_time = green_patience_timer.wait_time * 2
	
	green_patience_bar.max_value = green_patience_timer.wait_time
	red_patience_bar.max_value = red_patience_timer.wait_time
	
	if not green_patience_timer.is_stopped():
		# Still on the green patience bar
		# New value based on sped up timer
		var new_value = green_patience_bar.value * green_patience_timer.wait_time / temp_green_wait_time
		# TODO MAKE THIS NOT STUTTER IN THE PATIENCE BAR
		green_patience_timer.stop()
		green_patience_bar.value = new_value
		green_patience_timer.start(new_value)
		red_patience_bar.value = red_patience_bar.max_value
	elif not red_patience_timer.is_stopped():
		# On the red patience bar
		# New value based on sped up timer
		var new_value = red_patience_bar.value * red_patience_timer.wait_time / temp_red_wait_time
		red_patience_bar.value = new_value
		red_patience_timer.stop()
		red_patience_timer.start(new_value)


func get_bark() -> String:
	if green_patience_bar.value > 0:
		return "success"
	elif red_patience_bar.value > 0:
		return "late"
	else:
		return "damage"


func _on_green_patience_timer_timeout() -> void:
	red_patience_timer.start()


func _on_red_patience_timer_timeout() -> void:
	var bark_string: String = "C" + str(State.circle_num) + "_level_barks_"
	lover1.talk(State.dialogue_file, bark_string, 5.0)
	$LeaveTimer.start()


func _on_dance_timer_timeout() -> void:
	dance()


func _on_dance_intermission_timer_timeout() -> void:
	pass # Replace with function body.


func _on_leave_timer_timeout() -> void:
	SignalManager.life_lost.emit()
	AudioManager.play_sound(self, "res://audio/sfx/damage (2).wav", Enums.Audio_Type.SFX)
	lover1.clear_pair()
