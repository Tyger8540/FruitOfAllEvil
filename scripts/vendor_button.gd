class_name VendorButton
extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	if not %FarmersMarketCamera.at_entrance and not %FarmersMarketCamera.sidescrolling:
		$Label.text = State.vendor + "'s Stand"
		$Label.visible = true


func _on_mouse_exited() -> void:
	$Label.visible = false


func _on_button_up() -> void:
	$Label.visible = false
	if State.vendor == "Virgil" and not State.talked_to_virgil:
		State.section = "market_virgil_intro"
		State.talked_to_virgil = true
	else:
		State.section = "market_" + State.vendor.to_lower() + "_default"
	State.dialogue_ready = true
