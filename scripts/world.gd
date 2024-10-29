class_name World
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.player_lost.connect(on_player_lost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func on_player_lost() -> void:
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
