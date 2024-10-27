class_name WaveManager
extends Node2D


@export var num_days: int
var cur_day:= 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start_day() -> void:
	var difficulty_array: Array[int]
	var patience_array: Array[int]
	var difficulty_level: int
	difficulty_level = randi_range(1, 12)  # CHANGE THIS TO BE SOMEWHAT RANDOM (BASED ON ROUND)
	
	match cur_day:
		1:
			difficulty_array = [1, 1, 1, 1, 1]
			patience_array = [1, 1, 1, 1, 1]
		2:
			difficulty_array = [1, 2, 2, 4, 4, 5, 5]
			patience_array = [1, 1, 1, 1, 1, 1, 1]
		3:
			difficulty_array = [1, 2, 3, 3, 6, 6, 3, 5, 6, 4]
			patience_array = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
		4:
			difficulty_array = [4, 5, 6, 5, 6, 4, 6, 4, 5, 5]
			patience_array = [1, 2, 2, 1, 1, 2, 1, 2, 2, 2]
		5:
			difficulty_array = [3, 6, 2, 5, 3, 4, 5, 6, 1, 4, 3, 6]
			patience_array = [2, 2, 3, 2, 3, 2, 2, 3, 2, 2, 3, 3]
		6:
			difficulty_array = [7, 4, 2, 6, 8, 5, 9, 3, 9, 7, 6, 8]
			patience_array = [1, 3, 3, 2, 1, 2, 1, 3, 1, 1, 2, 1]
		7:
			difficulty_array = [9, 8, 7, 7, 9, 9, 8, 7, 8, 8, 9, 7, 8, 9, 7]
			patience_array = [1, 1, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 2]
		8:
			difficulty_array = [5, 9, 4, 1, 3, 9, 6, 8, 2, 8, 7, 6, 7, 4, 9]
			patience_array = [3, 2, 3, 3, 3, 2, 3, 2, 3, 2, 2, 3, 2, 3, 2]
		9:
			difficulty_array = [10, 5, 8, 12, 6, 11, 10, 3, 7, 12]
			patience_array = [1, 3, 3, 1, 3, 2, 2, 3, 3, 2]
		10:
			difficulty_array = [10, 12, 10, 11, 10, 12, 12, 11, 11, 10]
			patience_array = [3, 2, 3, 2, 3, 2, 2, 2, 2, 3]
		11:
			difficulty_array = [1, 11, 9, 5, 11, 8, 12, 10, 7, 2, 10, 12, 6, 8, 11]
			patience_array = [4, 2, 3, 4, 2, 3, 2, 2, 3, 4, 2, 2, 4, 3, 2]
		12:
			difficulty_array = [5, 9, 11, 7, 6, 12, 3, 8, 9, 10, 12, 4, 6, 8, 11]
			patience_array = [4, 4, 3, 4, 4, 3, 4, 4, 4, 3, 3, 4, 4, 4, 3]
		13:
			difficulty_array = [3, 1, 2, 5, 1, 6, 2, 4, 3, 5, 2, 1, 4, 2, 1, 5, 3]
			patience_array = [5, 5, 5, 4, 5, 4, 5, 5, 5, 4, 5, 5, 4, 5, 5, 4, 5]
		14:
			difficulty_array = [7, 10, 4, 9, 12, 11, 6, 8, 5, 10, 12, 7, 7, 11, 11, 4, 5, 12, 9, 10]
			patience_array = [5, 4, 6, 5, 4, 4, 6, 5, 6, 4, 4, 5, 5, 4, 4, 6, 6, 4, 5, 4]
		15:
			difficulty_array = [9, 6, 12, 12, 12, 6, 6, 9, 6, 12, 9, 9, 6, 12, 6, 12, 12, 9, 6, 12]
			patience_array = [6, 6, 5, 5, 5, 6, 6, 6, 6, 5, 6, 6, 6, 5, 6, 5, 5, 6, 6, 5]
	
	SignalManager.day_started.emit(difficulty_array, patience_array)


func finish_day() -> void:
	cur_day += 1
	pass
