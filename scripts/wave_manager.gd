class_name WaveManager
extends Node2D


@export var num_waves: int
var cur_wave:= 0
var day_started: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.tutorial_ended.connect(start_day)
	if not day_started and not (State.circle_num == 1 or State.circle_num == 2):
		start_day()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start_day() -> void:
	day_started = true
	var num_items: int
	var difficulty_array: Array[int]
	var patience_array: Array[int]
	var value_array: Array[int]
	var wait_time: float
	
	cur_wave += 1
	# setup for every day (15 for demo)
	match State.circle_num:
		0:
			match cur_wave:
				1:
					num_items = 5
					difficulty_array = [1, 1, 1, 1, 1]
					patience_array = [1, 1, 1, 1, 1]
					wait_time = 4.0
				2:
					num_items = 7
					difficulty_array = [1, 2, 2, 4, 4, 5, 5]
					patience_array = [1, 1, 1, 1, 1, 1, 1]
					wait_time = 5.0
				3:
					num_items = 10
					difficulty_array = [1, 2, 5, 4, 2, 5, 4, 2, 1, 5]
					patience_array = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
					wait_time = 6.0
		1:
			match cur_wave:
				1:
					num_items = 1
					difficulty_array = [1]
					patience_array = [1]
					wait_time = 4.0
				2:
					num_items = 1
					difficulty_array = [1]
					patience_array = [1]
					wait_time = 4.0
				3:
					num_items = 1
					difficulty_array = [1]
					patience_array = [1]
					wait_time = 4.0
				#1:
					#num_items = 5
					#difficulty_array = [3, 6, 6, 3, 6]
					#patience_array = [1, 1, 1, 1, 1]
					#wait_time = 4.0
				#2:
					#num_items = 7
					#difficulty_array = [3, 5, 6, 7, 2, 4, 8]
					#patience_array = [1, 1, 1, 1, 1, 1, 1]
					#wait_time = 5.0
				#3:
					#num_items = 10
					#difficulty_array = [4, 9, 6, 8, 5, 7, 9, 6, 8, 5]
					#patience_array = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
					#wait_time = 6.0
		2:
			match cur_wave:
				1:
					num_items = 12
					difficulty_array = [10, 10, 11, 12, 12, 11, 10, 10, 11, 11, 11, 12]
					patience_array = [3, 3, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1]
					wait_time = 5.0
				2:
					num_items = 12
					difficulty_array = [10, 10, 11, 12, 12, 11, 10, 10, 11, 11, 11, 12]
					patience_array = [2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3]
					wait_time = 5.0
				3:
					num_items = 12
					difficulty_array = [10, 10, 11, 12, 12, 11, 10, 10, 11, 11, 11, 12]
					patience_array = [3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4]
					wait_time = 5.0
				#1:
					#num_items = 2
					#difficulty_array = [1, 1]
					#patience_array = [1, 1]
					#wait_time = 5.0
				#2:
					#num_items = 2
					#difficulty_array = [1, 1]
					#patience_array = [1, 1]
					#wait_time = 5.0
				#3:
					#num_items = 2
					#difficulty_array = [1, 1]
					#patience_array = [1, 1]
					#wait_time = 5.0
		3:
			match cur_wave:
				1:
					num_items = 5
					difficulty_array = [1, 1, 1, 1, 1]
					patience_array = [1, 1, 1, 1, 1]
					wait_time = 4.0
				2:
					num_items = 7
					difficulty_array = [1, 2, 2, 4, 4, 5, 5]
					patience_array = [1, 1, 1, 1, 1, 1, 1]
					wait_time = 5.0
				3:
					num_items = 10
					difficulty_array = [1, 2, 3, 3, 6, 6, 3, 5, 6, 4]
					patience_array = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
					wait_time = 6.0
				4:
					num_items = 10
					difficulty_array = [4, 5, 6, 5, 6, 4, 6, 4, 5, 5]
					patience_array = [1, 2, 2, 1, 1, 2, 1, 2, 2, 2]
					wait_time = 6.5
				5:
					num_items = 12
					difficulty_array = [3, 6, 2, 5, 3, 4, 5, 6, 1, 4, 3, 6]
					patience_array = [2, 2, 3, 2, 3, 2, 2, 3, 2, 2, 3, 3]
					wait_time = 6.0
				6:
					num_items = 12
					difficulty_array = [7, 4, 2, 6, 8, 5, 9, 3, 9, 7, 6, 8]
					patience_array = [1, 3, 3, 2, 1, 2, 1, 3, 1, 1, 2, 1]
					wait_time = 5.5
				7:
					num_items = 15
					difficulty_array = [9, 8, 7, 7, 9, 9, 8, 7, 8, 8, 9, 7, 8, 9, 7]
					patience_array = [1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 2]
					wait_time = 6.5
				8:
					num_items = 15
					difficulty_array = [5, 9, 4, 1, 3, 9, 6, 8, 2, 8, 7, 6, 7, 4, 9]
					patience_array = [3, 2, 3, 3, 3, 2, 3, 2, 3, 2, 2, 3, 2, 3, 2]
					wait_time = 5.0
				9:
					num_items = 10
					difficulty_array = [10, 5, 8, 12, 6, 11, 10, 3, 7, 12]
					patience_array = [1, 3, 3, 1, 3, 2, 2, 3, 3, 2]
					wait_time = 6.0
				10:
					num_items = 10
					difficulty_array = [10, 12, 10, 11, 10, 12, 12, 11, 11, 10]
					patience_array = [3, 2, 3, 2, 3, 2, 2, 2, 2, 3]
					wait_time = 7.0
				11:
					num_items = 15
					difficulty_array = [1, 11, 9, 5, 11, 8, 12, 10, 7, 2, 10, 12, 6, 8, 11]
					patience_array = [4, 2, 3, 4, 2, 3, 2, 2, 3, 4, 2, 2, 4, 3, 2]
					wait_time = 5.0
				12:
					num_items = 15
					difficulty_array = [5, 9, 11, 7, 6, 12, 3, 8, 9, 10, 12, 4, 6, 8, 11]
					patience_array = [4, 4, 3, 4, 4, 3, 4, 4, 4, 3, 3, 4, 4, 4, 3]
					wait_time = 4.5
				13:
					num_items = 17
					difficulty_array = [3, 1, 2, 5, 1, 6, 2, 4, 3, 5, 2, 1, 4, 2, 1, 5, 3]
					patience_array = [5, 5, 5, 4, 5, 4, 5, 5, 5, 4, 5, 5, 4, 5, 5, 4, 5]
					wait_time = 4.0
				14:
					num_items = 20
					difficulty_array = [7, 10, 4, 9, 12, 11, 6, 8, 5, 10, 12, 7, 7, 11, 11, 4, 5, 12, 9, 10]
					patience_array = [5, 4, 6, 5, 4, 4, 6, 5, 6, 4, 4, 5, 5, 4, 4, 6, 6, 4, 5, 4]
					wait_time = 6.0
				15:
					num_items = 20
					difficulty_array = [9, 6, 12, 12, 12, 6, 6, 9, 6, 12, 9, 9, 6, 12, 6, 12, 12, 9, 6, 12]
					patience_array = [6, 6, 5, 5, 5, 6, 6, 6, 6, 5, 6, 6, 6, 5, 6, 5, 5, 6, 6, 5]
					wait_time = 5.0
	
	for i in range(0, num_items):
		value_array.append(difficulty_array[i] + 5)
	
	if Globals.upgrade_level[Enums.Upgrade_Type.MORE_PATIENCE] > 0:
		for i in range(0, num_items):
			patience_array[i] -= 1
			clampi(patience_array[i], 1, 100)
	
	%CustomerManager.create_customer_queue(difficulty_array, patience_array, value_array, wait_time)
	SignalManager.day_started.emit()


func finish_day() -> void:
	SignalManager.day_ended.emit()
	# LOGIC FOR SPENDING MONEY AND TIME IN BETWEEN ROUNDS WILL NEED TO GO HERE
	#start_day()
