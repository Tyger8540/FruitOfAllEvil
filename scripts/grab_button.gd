class_name GrabButton
extends TextureButton


const GRABBABLE_SCENE = preload("res://scenes/grabbable.tscn")
const FADE_FACTOR = 0.5
const LOW_FADE_BOUND = 1.0
const HIGH_FADE_BOUND = 1.25
const SCALE_FACTOR = 1.25

@export var fruit: Enums.Fruit_Type
@export var grab_type: Enums.Grabbable_Type

var hovering: bool = false
var fading_in: bool = false
var fading_out: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot_offset = Vector2(size.x / 2, size.y)  # Scales up from the center of the object
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logic for highlighting on hover
	if hovering:
		if fading_out:
			modulate.v -= FADE_FACTOR * delta
			#modulate.a -= FADE_FACTOR * delta
			if modulate.v <= LOW_FADE_BOUND:
				modulate.v = LOW_FADE_BOUND
				fading_in = true
				fading_out = false
		elif fading_in:
			modulate.v += FADE_FACTOR * delta
			if modulate.v >= HIGH_FADE_BOUND:
				modulate.v = HIGH_FADE_BOUND
				fading_in = false
				fading_out = true


func _on_button_up() -> void:
	# Only complete a button press if the player is hovering the button when released
	# Fixes the issue of trying to click and drag
	if hovering:
		if !Globals.is_grabbing:
			grab_fruit()
		elif Globals.is_grabbing:
			if Globals.grabbable_grab_type == grab_type:
				SignalManager.grabbable_placed.emit()
				if Globals.grabbable_fruit_type[0] == fruit:
					%PlaceOrGrabBackup.play()
				else:
					grab_fruit()


func grab_fruit() -> void:
	var grabbable = GRABBABLE_SCENE.instantiate()
	%Grab.play()
	Globals.grabbable_fruit_type[0] = fruit
	Globals.grabbable_grab_type = grab_type
	if grab_type == Enums.Grabbable_Type.FRUIT or grab_type == Enums.Grabbable_Type.CHOPPED_FRUIT:
		Globals.grabbable_fruit_type[1] = Enums.Fruit_Type.NONE
	var fruit_array: Array[Enums.Fruit_Type]
	fruit_array.append(fruit)
	grabbable.initialize(fruit_array, grab_type)
	get_tree().get_root().add_child(grabbable)
	Globals.is_grabbing = true


func _on_mouse_entered() -> void:
	hovering = true
	fading_in = true
	fading_out = false
	scale *= SCALE_FACTOR


func _on_mouse_exited() -> void:
	hovering = false
	fading_in = false
	fading_out = false
	modulate.v = LOW_FADE_BOUND
	scale /= SCALE_FACTOR
