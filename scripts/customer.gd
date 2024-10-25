extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var difficulty:= 0


func _physics_process(_delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	pass

func initialize(texture: Texture2D, difficulty_level: int) -> void:
	$Sprite2D.texture = texture
	difficulty = difficulty_level
	form_options()


func form_options() -> void:
	var textures: Array[Texture2D]
	var fruits: Array[Enums.Fruit_Type]
	var grab_types: Array[Enums.Grabbable_Type]
	var num_items: int
	
	match difficulty:
		0:
			num_items = 1
			var i = randi_range(1, 5)
			match i:
				1:
					textures.append(load("res://art/fruit/Apple.png"))
					fruits.append(Enums.Fruit_Type.APPLE)
				2:
					textures.append(load("res://art/fruit/Orange.png"))
					fruits.append(Enums.Fruit_Type.ORANGE)
				3:
					textures.append(load("res://art/fruit/Banana.png"))
					fruits.append(Enums.Fruit_Type.BANANA)
				4:
					textures.append(load("res://art/fruit/Blueberries.png"))
					fruits.append(Enums.Fruit_Type.BLUEBERRIES)
				5:
					textures.append(load("res://art/fruit/Plum.png"))
					fruits.append(Enums.Fruit_Type.PLUM)
			grab_types.append(Enums.Grabbable_Type.FRUIT)
		1:
			pass
		2:
			pass
			
		
	
	$CustomerButton.set_grid(textures, fruits, grab_types)
