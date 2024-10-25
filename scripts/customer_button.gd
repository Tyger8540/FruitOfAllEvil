class_name CustomerButton
extends Button

var slots: Array[TextureRect]
var checkmarks: Array[TextureRect]

var fruit: Array[Enums.Fruit_Type]
var grab_type: Array[Enums.Grabbable_Type]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hi")
	slots = [$Panel/ItemGrid/Slot1, $Panel/ItemGrid/Slot2, $Panel/ItemGrid/Slot3, $Panel/ItemGrid/Slot4]
	checkmarks = [$Panel/Checkmark1, $Panel/Checkmark2, $Panel/Checkmark3, $Panel/Checkmark4]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_grid(texture_array: Array[Texture2D], fruit_array: Array[Enums.Fruit_Type], grab_type_array: Array[Enums.Grabbable_Type]) -> void:
	for i in range(0, texture_array.size()):
		slots[i].texture = texture_array[i]
		fruit.append(fruit_array[i])
		grab_type.append(grab_type_array[i])


func check_completed() -> void:
	# check if this customer has been given all of their required items
	for i in range(0, fruit.size()):
		if !checkmarks[i].visible:
			return
	# the for loop finished, so everything was checked off
	start_leave_sequence()


func start_leave_sequence() -> void:
	print("start_leave_sequence")
	$Panel/Label.visible = true
	$LeaveTimer.start()


func _on_button_up() -> void:
	if Globals.is_grabbing:
		for i in range(0, fruit.size()):
			if !checkmarks[i].visible and fruit[i] == Globals.grabbable_fruit_type and grab_type[i] == Globals.grabbable_grab_type:
				# the grabbed fruit can be placed here when it has not been checked off and matches fruit and grab_type
				checkmarks[i].visible = true
				SignalManager.grabbable_placed.emit()
				check_completed()


func _on_temp_timer_timeout() -> void:
	var t: Array[Texture2D] = [load("res://art/Apple2.png"), load("res://art/Apple3.png"), load("res://art/Orange2.png"), load("res://art/Orange1.png")]
	var f: Array[Enums.Fruit_Type] = [Enums.Fruit_Type.APPLE, Enums.Fruit_Type.APPLE, Enums.Fruit_Type.ORANGE, Enums.Fruit_Type.ORANGE]
	var g: Array[Enums.Grabbable_Type] = [Enums.Grabbable_Type.CHOPPED_FRUIT, Enums.Grabbable_Type.BLENDED_FRUIT, Enums.Grabbable_Type.CHOPPED_FRUIT, Enums.Grabbable_Type.FRUIT]
	set_grid(t, f, g)


func _on_leave_timer_timeout() -> void:
	# this seems like not good practice
	SignalManager.new_customer_spawned.emit()
	$"..".queue_free()
