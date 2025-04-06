class_name LustPair
extends Node2D

const LOVER_OFFSET = 70.0

@export var lover1: LustCustomer
@export var lover2: LustCustomer

var initialized: bool = false

@onready var green_patience_bar: TextureProgressBar = $GreenPatienceBar
@onready var red_patience_bar: TextureProgressBar = $RedPatienceBar

@onready var green_patience_timer: Timer = $GreenPatienceTimer
@onready var red_patience_timer: Timer = $RedPatienceTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if green_patience_bar.visible and green_patience_bar.value > 0 and !green_patience_timer.is_stopped():
		green_patience_bar.value = green_patience_timer.time_left
	elif !red_patience_timer.is_stopped():
		red_patience_bar.value = red_patience_timer.time_left


func initialize(index: int) -> void:
	# Make the pair spawn outside the bounds of the screen, then make their way in
	# to simulate people making their way to the ballroom
	position = Vector2(-800.0 + 300.0 * index, 70.0)
	lover1.position.x -= LOVER_OFFSET
	lover2.position.x += LOVER_OFFSET
	set_patience_timers()
	green_patience_timer.start()
	initialized = true


func set_patience_timers() -> void:
	green_patience_timer.wait_time = lover1.green_patience_timer.wait_time + lover2.green_patience_timer.wait_time
	green_patience_bar.max_value = green_patience_timer.wait_time
	red_patience_timer.wait_time = 2 * green_patience_timer.wait_time
	red_patience_bar.max_value = red_patience_timer.wait_time
	red_patience_bar.value = red_patience_bar.max_value


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
		green_patience_timer.start(new_value)
	elif not red_patience_timer.is_stopped():
		# On the red patience bar
		# New value based on sped up timer
		var new_value = red_patience_bar.value * red_patience_timer.wait_time / temp_red_wait_time
		red_patience_timer.start(new_value)


func _on_green_patience_timer_timeout() -> void:
	red_patience_timer.start()


func _on_red_patience_timer_timeout() -> void:
	SignalManager.life_lost.emit()
	AudioManager.play_sound(self, "res://audio/sfx/damage (2).wav", Enums.Audio_Type.SFX)
	queue_free()
