extends Control


var poster_index: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.stop_music()
	AudioManager.play_sound(self, "res://audio/music/Epic Vol2 Challenger Intensity 1.wav", Enums.Audio_Type.MUSIC)
	match State.circle_num:
		0:
			$ProloguePanel.visible = true
		1:
			$Circle1Panel.visible = true
		2:
			$Circle2Panel.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space") || Input.is_action_just_pressed("click"):
		match State.circle_num:
			0:
				match poster_index:
					0:
						$ProloguePanel/TextureRect2.visible = true
						poster_index += 1
					1:
						$ProloguePanel/TextureRect3.visible = true
						poster_index += 1
					2:
						get_tree().change_scene_to_file("res://scenes/prologue.tscn")
			1:
				State.dialogue_ready = true
				get_tree().change_scene_to_file("res://scenes/circle_one.tscn")
			2:
				State.dialogue_ready = true
				get_tree().change_scene_to_file("res://scenes/circle_two.tscn")
