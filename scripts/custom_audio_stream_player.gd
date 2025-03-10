class_name CustomAudioStreamPlayer
extends AudioStreamPlayer

var type: Enums.Audio_Type = Enums.Audio_Type.NONE

var initialized: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if initialized and not playing:
		queue_free()


func initialize_and_play(_file_name: String, _type: Enums.Audio_Type, _volume: float = 0.0) -> void:
	stream = load(_file_name)
	type = _type
	volume_db = _volume
	play()
	initialized = true
