class_name Boss
extends Node2D

@export var boss_name: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.boss_fight_started.connect(start_boss_fight)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_boss_fight() -> void:
	# Logic for starting the boss fight when signal is received (will be done in subclasses)
	if State.next_boss != boss_name:
		return
