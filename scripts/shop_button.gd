class_name ShopButton
extends Button


var price: int
var upgrade: Enums.Upgrade_Type


func _on_button_up() -> void:
	if Globals.money >= price:
		Globals.money -= price
		Globals.upgrade_level[upgrade] += 1
		%CoinSpend.play()
		SignalManager.upgrade_purchased.emit()
		set_up_button()


func initialize(upgrade_type: Enums.Upgrade_Type) -> void:
	upgrade = upgrade_type
	set_up_button()


func set_up_button() -> void:
	match upgrade:
		Enums.Upgrade_Type.MORE_PATIENCE:
			$Label.text = "+ Patience"
			price = 50 + (100 * Globals.upgrade_level[Enums.Upgrade_Type.MORE_PATIENCE])
			$PricePanel/Label.text = "$" + str(price)
		Enums.Upgrade_Type.CHOPPING_BOARD:
			$Label.text = "+ Chop Board"
			price = 200 + (200 * Globals.upgrade_level[Enums.Upgrade_Type.CHOPPING_BOARD])
			$PricePanel/Label.text = "$" + str(price)
		Enums.Upgrade_Type.CHOP_SPEED:
			$Label.text = "+ Chop Speed"
			price = 25 + (50 * Globals.upgrade_level[Enums.Upgrade_Type.CHOP_SPEED])
			$PricePanel/Label.text = "$" + str(price)
		Enums.Upgrade_Type.BLENDER:
			$Label.text = "+ Blender"
			price = 250 + (250 * Globals.upgrade_level[Enums.Upgrade_Type.BLENDER])
			$PricePanel/Label.text = "$" + str(price)
		Enums.Upgrade_Type.BLEND_SPEED:
			$Label.text = "+ Blend Speed"
			price = 50 + (75 * Globals.upgrade_level[Enums.Upgrade_Type.BLEND_SPEED])
			$PricePanel/Label.text = "$" + str(price)
		Enums.Upgrade_Type.NONE:
			$Label.text = "Out of Stock"
			price = 999999999999
			$PricePanel/Label.text = ""
