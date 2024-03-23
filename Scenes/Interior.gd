extends Sprite2D
var damage_upgrade_cost = 1
var speed_upgrade_cost = 1
var reload_upgrade_cost = 1


func _on_perma_damage_button_pressed():
	$PermaAcceptDialog.title = "DMG"	
	$PermaAcceptDialog.visible = true
	if GlobalVars.current_money >= damage_upgrade_cost:
		$PermaAcceptDialog.dialog_text = "Make your babies bite harder on impact? Cost: $" + str(damage_upgrade_cost)
	else:
		$PermaAcceptDialog.dialog_text = "You're broke... You need $" + str(damage_upgrade_cost)
	
func _on_perma_speed_button_pressed():
	$PermaAcceptDialog.title = "SPD"	
	$PermaAcceptDialog.visible = true
	if GlobalVars.current_money >= speed_upgrade_cost:
		$PermaAcceptDialog.dialog_text = "Make your babies more aerodynamic? Cost: $" + str(speed_upgrade_cost)
	else:
		$PermaAcceptDialog.dialog_text = "You're broke... You need $" + str(speed_upgrade_cost)
		
func _on_perma_dexterity_button_pressed():
	$PermaAcceptDialog.title = "DEX"	
	$PermaAcceptDialog.visible = true
	if GlobalVars.current_money >= reload_upgrade_cost:
		$PermaAcceptDialog.dialog_text = "Reload your babies faster? Cost: $" + str(reload_upgrade_cost)
	else:
		$PermaAcceptDialog.dialog_text = "You're broke... You need $" + str(reload_upgrade_cost)
	
	
func _on_perma_accept_dialog_confirmed():
	if "You're broke..." in $PermaAcceptDialog.dialog_text:
		return
	if $PermaAcceptDialog.title == "DMG":
		GlobalVars.current_money -= damage_upgrade_cost
		damage_upgrade_cost *= 2
		PermaUpgrades.dmg_lvl += 1
		$PermaDamageIndicator.frame = PermaUpgrades.dmg_lvl
		
	if $PermaAcceptDialog.title == "SPD":
		GlobalVars.current_money -= speed_upgrade_cost
		speed_upgrade_cost *= 2
		PermaUpgrades.spd_lvl += 1
		$PermaSpeedIndicator.frame = PermaUpgrades.spd_lvl
		
	if $PermaAcceptDialog.title == "DEX":
		GlobalVars.current_money -= reload_upgrade_cost
		reload_upgrade_cost *= 2
		PermaUpgrades.reload_lvl += 1
		$PermaDexterityIndicator.frame = PermaUpgrades.reload_lvl



func _on_perma_accept_dialog_canceled():
	print("HELLA NAH")


