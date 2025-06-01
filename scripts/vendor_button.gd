class_name VendorButton
extends Button


var hovering: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_label_visible(_visible: bool) -> void:
	if hovering and not %FarmersMarketCamera.at_entrance:
		$Label.text = State.vendor + "'s Stand"
		$Label.visible = _visible
	else:
		$Label.text = State.vendor + "'s Stand"
		$Label.visible = false


func _on_mouse_entered() -> void:
	hovering = true
	if (not %FarmersMarketCamera.at_entrance and
		not %FarmersMarketCamera.sidescrolling and 
		not %FarmersMarketCamera.fading_in and
		not %FarmersMarketCamera.fading_out):
		$Label.text = State.vendor + "'s Stand"
		$Label.visible = true


func _on_mouse_exited() -> void:
	hovering = false
	$Label.visible = false


func _on_button_up() -> void:
	if $Label.visible:
		$Label.visible = false
		if State.vendor == "Virgil" and not State.talked_to_virgil:
			State.section = "market_virgil_intro"
			State.talked_to_virgil = true
		elif State.vendor == "DJ Virgil":
			print("DJ Virgil")
			State.section = "market_virgil_default"
		else:
			State.section = "market_" + State.vendor.to_lower() + "_default"
		State.dialogue_ready = true
		%FarmersMarketCamera.set_sidescroll_buttons_invisible()
