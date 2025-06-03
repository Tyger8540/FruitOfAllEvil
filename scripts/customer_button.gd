class_name CustomerButton
extends Button

const HIGHLIGHT_FACTOR = 0.5
const LOW_HIGHLIGHT_BOUND = 1.0
const HIGH_HIGHLIGHT_BOUND = 1.25
const SCALE_FACTOR = 1.25

var slots: Array[GrabbableTexture]
var checkmarks: Array[TextureRect]

var fruit: Array[Enums.Fruit_Type]
var grab_type: Array[Enums.Grabbable_Type]
var fruit2: Array[Enums.Fruit_Type]

var late_order_strings: Array[String]
var damage_strings: Array[String]

var hovering:= false
var highlighting:= false
var result: Dictionary

var audio_stream_players: Array[AudioStreamPlayer]

@onready var sprite_2d: Sprite2D = $"../Sprite2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slots = [$Panel/ItemGrid/Slot1, $Panel/ItemGrid/Slot2, $Panel/ItemGrid/Slot3, $Panel/ItemGrid/Slot4]
	checkmarks = [$Panel/Checkmark1, $Panel/Checkmark2, $Panel/Checkmark3, $Panel/Checkmark4]
	late_order_strings = ["I'll let it slide this time", "Thanks but I'm not paying you", "Speed it up", "Finally", "Took you long enough"]
	damage_strings = ["Thanks for your heart", "Ha! Take that", "Hehehe I've got your heart"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func set_grid(texture_array: Array[GrabbableTexture], fruit_array: Array[Enums.Fruit_Type], grab_type_array: Array[Enums.Grabbable_Type], fruit_array2: Array[Enums.Fruit_Type]) -> void:
	for i in range(0, texture_array.size()):
		print("texture: " + str(texture_array[i].texture))
		#slots[i] = texture_array[i]
		#slots[i].texture = texture_array[i].texture
		#slots[i].top_blended_fruit.texture = texture_array[i].top_blended_fruit.texture
		#slots[i].bottom_blended_fruit.texture = texture_array[i].bottom_blended_fruit.texture
		slots[i].set_grabbable_texture(texture_array[i])
		print("slot texture: " + str(slots[i].texture))
		fruit.append(fruit_array[i])
		grab_type.append(grab_type_array[i])
		fruit2.append(fruit_array2[i])


func check_completed() -> void:
	# check if this customer has been given all of their required items
	for i in range(0, fruit.size()):
		if !checkmarks[i].visible:
			return
	# the for loop finished, so everything was checked off
	if get_parent() is LustCustomer:
		get_parent().is_completed = true
	start_leave_sequence()


func start_leave_sequence() -> void:
	var bark_string: String = "C" + str(State.circle_num) + "_level_barks_"
	
	if $GreenPatienceBar.value > 0:
		$GreenPatienceTimer.stop()
		AudioManager.play_sound(self, "res://audio/sfx/Coin_Get.wav", Enums.Audio_Type.SFX)
		if $GreenPatienceBar.value >= $GreenPatienceTimer.wait_time / 2:
			get_parent().talk(State.dialogue_file, bark_string + "success", 5.0)
			$Panel/Label.text = "$" + str(get_parent().sell_value)
			Globals.money += get_parent().sell_value
		else:
			get_parent().talk(State.dialogue_file, bark_string + "success", 5.0)
			$Panel/Label.text = "$" + str(get_parent().sell_value / 2)
			Globals.money += get_parent().sell_value / 2
	elif $RedPatienceBar.value > 0:
		$RedPatienceTimer.stop()
		AudioManager.play_sound(self, "res://audio/sfx/disatisfied.wav", Enums.Audio_Type.SFX)
		get_parent().talk(State.dialogue_file, bark_string + "late", 5.0)
		var i = randi_range(0, late_order_strings.size() - 1)
		$Panel/Label.text = late_order_strings[i]
	else:
		get_parent().talk(State.dialogue_file, bark_string + "damage", 5.0)
		var i = randi_range(0, damage_strings.size() - 1)
		$Panel/Label.text = damage_strings[i]
	
	if get_parent() is CharonCustomer:
		get_parent().die()
	else:
		$LeaveTimer.start()


func play_eat_sound() -> void:
	AudioManager.play_sound(self, "res://audio/sfx/satisfied (2).wav", Enums.Audio_Type.SFX, -10.0)
	#var i = randi_range(1, 2)
	#if i == 1:
		#%Eat1.play()
	#else:
		#%Eat2.play()


func grabbable_needed() -> Dictionary:
	# Checks if the grabbable is needed by this customer
	for i in range(0, fruit.size()):
		if (
				not checkmarks[i].visible
				and fruit[i] == Globals.grabbable_fruit_type[0]
				and grab_type[i] == Globals.grabbable_grab_type
				and fruit2[i] == Globals.grabbable_fruit_type[1]
		):
			return {"needed": true, "index": i}
	return {"needed": false}


func set_highlight(mouse_entered: bool) -> void:
	if mouse_entered:
		# Mouse entered
		hovering = true
		if (
				$GreenPatienceTimer.is_stopped() and not $RedPatienceTimer.is_stopped()
				or not $GreenPatienceTimer.is_stopped() and $RedPatienceTimer.is_stopped()
		):
			# Customer is interactable
			if Globals.is_grabbing:
				result = grabbable_needed()
				if result["needed"]:
					# Customer button is highlighted when trying to give an item they want
					highlighting = true
					sprite_2d.scale *= SCALE_FACTOR
					sprite_2d.position.y += 40.0
					#scale *= SCALE_FACTOR
	else:
		# Mouse exited
		hovering = false
		if (
				$GreenPatienceTimer.is_stopped() and not $RedPatienceTimer.is_stopped()
				or not $GreenPatienceTimer.is_stopped() and $RedPatienceTimer.is_stopped()
		):
			# Customer is interactable
			if Globals.is_grabbing:
				# Grabbing
				if result["needed"]:
					highlighting = false
					sprite_2d.modulate.v = LOW_HIGHLIGHT_BOUND
					#modulate.v = LOW_HIGHLIGHT_BOUND
					sprite_2d.scale /= SCALE_FACTOR
					sprite_2d.position.y -= 40.0
					#scale /= SCALE_FACTOR


func _on_button_up() -> void:
	# Only complete a button press if the player is hovering the button when released
	# Fixes the issue of trying to click and drag
	if hovering:
		if Globals.is_grabbing:
			if highlighting:
				# The grabbed fruit can be placed here when it has not been checked off and matches fruit and grab_type
				var i: int = result["index"]
				checkmarks[i].visible = true
				set_highlight(false)
				play_eat_sound()
				SignalManager.grabbable_placed.emit()
				check_completed()


func _on_leave_timer_timeout() -> void:
	get_parent().die()


func _on_mouse_entered() -> void:
	set_highlight(true)


func _on_mouse_exited() -> void:
	set_highlight(false)
