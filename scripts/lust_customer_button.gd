class_name LustCustomerButton
extends CustomerButton

const FADE_FACTOR = 0.5
const LOW_FADE_BOUND = 1.0
const HIGH_FADE_BOUND = 1.25

var fading_in: bool = false
var fading_out: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out:
		sprite_2d.modulate.v -= FADE_FACTOR * delta
		#modulate.a -= FADE_FACTOR * delta
		if sprite_2d.modulate.v <= LOW_FADE_BOUND:
			sprite_2d.modulate.v = LOW_FADE_BOUND
			fading_in = true
			fading_out = false
	elif fading_in:
		sprite_2d.modulate.v += FADE_FACTOR * delta
		if sprite_2d.modulate.v >= HIGH_FADE_BOUND:
			sprite_2d.modulate.v = HIGH_FADE_BOUND
			fading_in = false
			fading_out = true
	else:
		sprite_2d.modulate.v = LOW_FADE_BOUND


func start_leave_sequence() -> void:
	if get_parent().lover.is_completed:
		get_parent().pause_timers()
	
	var bark_string: String = "C" + str(State.circle_num) + "_level_barks_"
	
	if not get_parent().lover.is_completed:
		return
	else:  # get_parent().lover.is_completed
		get_parent().talk(State.dialogue_file, bark_string, 5.0)
	
	get_parent().get_parent().add_money()
	
	$LeaveTimer.start()


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
					#get_parent().lover.highlighting = true
					get_parent().lover.customer_button.sprite_2d.scale *= SCALE_FACTOR
					get_parent().lover.customer_button.sprite_2d.position.y += 40.0
					#get_parent().lover.customer_button
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
					
					#get_parent().highlighting = false
					get_parent().lover.customer_button.sprite_2d.modulate.v = LOW_HIGHLIGHT_BOUND
					get_parent().lover.customer_button.sprite_2d.scale /= SCALE_FACTOR
					get_parent().lover.customer_button.sprite_2d.position.y -= 40.0
					#scale /= SCALE_FACTOR
