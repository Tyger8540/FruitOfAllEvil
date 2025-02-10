extends Node


const FULLSCREEN_BALLOON = preload("res://dialogue/fullscreen_balloon.tscn")
const FARMERS_MARKET_BALLOON = preload("res://dialogue/farmers_market_balloon.tscn")
const CUTSCENE_BALLOON = preload("res://dialogue/cutscene_balloon.tscn")

#var dialogue_ready: bool = true
#var intro_started: bool = false
#var level_intro_started: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if State.dialogue_ready:
		handle_input()
		State.dialogue_ready = false
	#if State.location == "intro" and not intro_started and State.section == "C0_intro":
		#handle_input()
		#intro_started = true
	#elif State.location == "level" and not level_intro_started and State.section == "C0_level_virgil":
		#handle_input()
		#level_intro_started = true
	pass


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		handle_input()


func handle_input() -> void:
	var balloon: Node
	match State.location:
		"intro":
			balloon = FULLSCREEN_BALLOON.instantiate()
		"level":
			if State.level_defeated:
				balloon = CUTSCENE_BALLOON.instantiate()
			else:
				return
		"boss":
			match State.next_boss:
				"Charon":
					return
		"market":
			balloon = FARMERS_MARKET_BALLOON.instantiate()
			match State.vendor:
				"Virgil":
					pass
				"Ovid":
					pass
				_:
					return
		_:
			return
	
	get_tree().current_scene.add_child(balloon)
	balloon.start(load(State.dialogue_file), State.section)
	#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/prologue.dialogue"), "C0_intro")
	return
