class_name ShopManager
extends Node2D


func _ready() -> void:
	SignalManager.day_started.connect(on_day_start)
	SignalManager.day_ended.connect(on_day_end)


func on_day_start() -> void:
	$Background.visible = false


func on_day_end() -> void:
	if %WaveManager.cur_day == 15:
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
	var upgrades_indices_picked: Array[int]
	for i in range(0, 4):
		var r = randi_range(0, Enums.Upgrade_Type.size() - 2)  # random int that gets an upgrade that is not NONE
		while r in upgrades_indices_picked:
			r = randi_range(0, Enums.Upgrade_Type.size() - 2)  # random int that gets an upgrade that is not NONE
		if %WaveManager.cur_day == 1 and !upgrades_indices_picked.has(2):
			r = 2  # makes sure day one shop has chop speed upgrade
		upgrades_indices_picked.append(r)
		match i:
			0:
				match r:
					0:
						$Background/ShopButton.initialize(Enums.Upgrade_Type.MORE_PATIENCE)
					1:
						$Background/ShopButton.initialize(Enums.Upgrade_Type.CHOPPING_BOARD)
					2:
						$Background/ShopButton.initialize(Enums.Upgrade_Type.CHOP_SPEED)
					3:
						$Background/ShopButton.initialize(Enums.Upgrade_Type.BLENDER)
					4:
						$Background/ShopButton.initialize(Enums.Upgrade_Type.BLEND_SPEED)
			1:
				match r:
					0:
						$Background/ShopButton2.initialize(Enums.Upgrade_Type.MORE_PATIENCE)
					1:
						$Background/ShopButton2.initialize(Enums.Upgrade_Type.CHOPPING_BOARD)
					2:
						$Background/ShopButton2.initialize(Enums.Upgrade_Type.CHOP_SPEED)
					3:
						$Background/ShopButton2.initialize(Enums.Upgrade_Type.BLENDER)
					4:
						$Background/ShopButton2.initialize(Enums.Upgrade_Type.BLEND_SPEED)
			2:
				match r:
					0:
						$Background/ShopButton3.initialize(Enums.Upgrade_Type.MORE_PATIENCE)
					1:
						$Background/ShopButton3.initialize(Enums.Upgrade_Type.CHOPPING_BOARD)
					2:
						$Background/ShopButton3.initialize(Enums.Upgrade_Type.CHOP_SPEED)
					3:
						$Background/ShopButton3.initialize(Enums.Upgrade_Type.BLENDER)
					4:
						$Background/ShopButton3.initialize(Enums.Upgrade_Type.BLEND_SPEED)
			3:
				match r:
					0:
						$Background/ShopButton4.initialize(Enums.Upgrade_Type.MORE_PATIENCE)
					1:
						$Background/ShopButton4.initialize(Enums.Upgrade_Type.CHOPPING_BOARD)
					2:
						$Background/ShopButton4.initialize(Enums.Upgrade_Type.CHOP_SPEED)
					3:
						$Background/ShopButton4.initialize(Enums.Upgrade_Type.BLENDER)
					4:
						$Background/ShopButton4.initialize(Enums.Upgrade_Type.BLEND_SPEED)
	$Background.visible = true
