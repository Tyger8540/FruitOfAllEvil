class_name CustomerButton
extends Button

var slots: Array[TextureRect]
var checkmarks: Array[TextureRect]

var fruit: Array[Enums.Fruit_Type]
var grab_type: Array[Enums.Grabbable_Type]
var fruit2: Array[Enums.Fruit_Type]

var late_order_strings: Array[String]
var damage_strings: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slots = [$Panel/ItemGrid/Slot1, $Panel/ItemGrid/Slot2, $Panel/ItemGrid/Slot3, $Panel/ItemGrid/Slot4]
	checkmarks = [$Panel/Checkmark1, $Panel/Checkmark2, $Panel/Checkmark3, $Panel/Checkmark4]
	late_order_strings = ["I'll let it slide this time", "Thanks but I'm not paying you", "Speed it up", "Finally", "Took you long enough"]
	damage_strings = ["Thanks for your heart", "Ha! Take that", "Hehehe I've got your heart"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func set_grid(texture_array: Array[Texture2D], fruit_array: Array[Enums.Fruit_Type], grab_type_array: Array[Enums.Grabbable_Type], fruit_array2: Array[Enums.Fruit_Type]) -> void:
	for i in range(0, texture_array.size()):
		slots[i].texture = texture_array[i]
		fruit.append(fruit_array[i])
		grab_type.append(grab_type_array[i])
		fruit2.append(fruit_array2[i])


func check_completed() -> void:
	# check if this customer has been given all of their required items
	for i in range(0, fruit.size()):
		if !checkmarks[i].visible:
			return
	# the for loop finished, so everything was checked off
	#%CoinGet.play()
	start_leave_sequence()


func start_leave_sequence() -> void:
	if $GreenPatienceBar.value > 0:
		$GreenPatienceTimer.stop()
		if $GreenPatienceBar.value >= $GreenPatienceTimer.wait_time / 2:
			$Panel/Label.text = "$" + str(get_parent().sell_value)
			Globals.money += get_parent().sell_value
		else:
			$Panel/Label.text = "$" + str(get_parent().sell_value / 2)
			Globals.money += get_parent().sell_value / 2
	elif $RedPatienceBar.value > 0:
		$RedPatienceTimer.stop()
		var i = randi_range(0, late_order_strings.size() - 1)
		$Panel/Label.text = late_order_strings[i]
	else:
		var i = randi_range(0, damage_strings.size() - 1)
		$Panel/Label.text = damage_strings[i]
	#$Panel/Label.visible = true
	$LeaveTimer.start()


func play_eat_sound() -> void:
	var i = randi_range(1, 2)
	if i == 1:
		%Eat1.play()
	else:
		%Eat2.play()


func set_highlight(mouse_entered: bool) -> void:
	#if mouse_entered:
		## Mouse entered
		#hovering = true
		#if Globals.is_grabbing:
			## Customer button is highlighted when trying to give an item
			#highlighting = true
			#highlight_target = get_parent()
			#highlight_target.scale *= SCALE_FACTOR
	#else:
		## Mouse exited
		#if is_in_action:
			#hovering = false
		#elif highlight_target != null:
			#hovering = false
			#highlighting = false
			#highlight_target.modulate.v = LOW_HIGHLIGHT_BOUND
			#highlight_target.scale /= SCALE_FACTOR
			#if appliance_type != Appliance_Type.SHELF:
				#$RemoteTransform2D.update_position = true
			#highlight_target = null
	pass


func _on_button_up() -> void:
	if Globals.is_grabbing:
		for i in range(0, fruit.size()):
			if !checkmarks[i].visible and fruit[i] == Globals.grabbable_fruit_type[0] and grab_type[i] == Globals.grabbable_grab_type and fruit2[i] == Globals.grabbable_fruit_type[1]:
				# the grabbed fruit can be placed here when it has not been checked off and matches fruit and grab_type
				checkmarks[i].visible = true
				play_eat_sound()
				SignalManager.grabbable_placed.emit()
				check_completed()
				break


func _on_leave_timer_timeout() -> void:
	get_parent().die()


func _on_mouse_entered() -> void:
	set_highlight(true)


func _on_mouse_exited() -> void:
	set_highlight(false)
