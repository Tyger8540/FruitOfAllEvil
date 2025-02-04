class_name Charon_Boss
extends Boss

@export var customers: Array[Customer]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		start_boss_fight()


func start_boss_fight() -> void:
	#super()  # Makes sure this is the boss fight that should start
	
	for customer in customers:
		var rand_difficulty := randi_range(7, 12)
		customer.initialize_stationary(null, rand_difficulty, 1, 62.0, 0)
