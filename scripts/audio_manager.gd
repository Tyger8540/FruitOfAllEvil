extends Node


func play_sound(caller: Node, audio_file_name: String, audio_type: Enums.Audio_Type, volume: float = 0.0) -> void:
	var new_audio:= CustomAudioStreamPlayer.new()
	if audio_type == Enums.Audio_Type.MUSIC:
		add_child(new_audio)  # Music is a child of the Audio Manager
	else:
		caller.add_child(new_audio)  # SFX is a child of the sound calling it
	new_audio.initialize_and_play(audio_file_name, audio_type, volume)


func stop_music() -> void:
	for audio_child in get_children():
		if audio_child is CustomAudioStreamPlayer:
			if audio_child.type == Enums.Audio_Type.MUSIC:
				audio_child.queue_free()
