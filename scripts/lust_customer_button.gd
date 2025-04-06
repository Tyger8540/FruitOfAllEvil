class_name LustCustomerButton
extends CustomerButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_highlight(mouse_entered: bool) -> void:
	var pair = get_parent().get_parent()
	if mouse_entered:
		# Mouse entered
		hovering = true
		if (
				pair.green_patience_timer.is_stopped() and not pair.red_patience_timer.is_stopped()
				or not pair.green_patience_timer.is_stopped() and pair.red_patience_timer.is_stopped()
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
				pair.green_patience_timer.is_stopped() and not pair.red_patience_timer.is_stopped()
				or not pair.green_patience_timer.is_stopped() and pair.red_patience_timer.is_stopped()
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
