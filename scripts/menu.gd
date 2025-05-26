extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_button_up() -> void:
	if State.location == "intro":
		get_tree().change_scene_to_file("res://scenes/fullscreen_cutscene.tscn")


func _on_restart_button_button_up() -> void:
	match State.circle_num:
		0:
			State.location = "level"
			State.section = "C0_level_virgil"
			State.cutscene_speaker = "Virgil"
			get_tree().change_scene_to_file("res://scenes/prologue.tscn")
		1:
			State.location = "level"
			State.section = "C1_level_virgil1"
			State.cutscene_speaker = "Virgil"
			get_tree().change_scene_to_file("res://scenes/circle_one.tscn")
		2:
			State.location = "level"
			State.section = "C2_level_virgil1"
			State.cutscene_speaker = "DJ Virgil"
			State.dialogue_ready = true
			get_tree().change_scene_to_file("res://scenes/circle_two.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_settings_button_button_up() -> void:
	pass # Replace with function body.
