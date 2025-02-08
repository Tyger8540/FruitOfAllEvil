class_name Charon_Boss
extends Boss

@export var customers: Array[Customer]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("space"):
		#start_boss_fight()
	pass


func start_boss_fight() -> void:
	#super()  # Makes sure this is the boss fight that should start
	
	for customer in customers:
		var rand_difficulty := randi_range(7, 12)
		var customer_sprite: Texture2D
		var i = randi_range(1, 2)
		if i == 1:
			customer_sprite = load("res://final_art/Grotesquelimbo_ok_360.png")  # CHANGE THIS TO BE RANDOM WHEN HAVE MORE CUSTOMER SPRITES
		else:
			customer_sprite = load("res://final_art/Grotesquelimbo_sadge_360.png")
		customer.initialize(customer_sprite, rand_difficulty, 1, 62.0, 0, 0)  # TODO CHANGE FROM ALWAYS 62.0
