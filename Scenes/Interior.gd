extends Sprite2D


func _on_perma_damage_button_pressed():
	$PermaAcceptDialog.title = "DMG"	
	$PermaAcceptDialog.dialog_text = "Make your babies bite harder on impact?"
	$PermaAcceptDialog.visible = true


func _on_perma_speed_button_pressed():
	$PermaAcceptDialog.title = "SPD"	
	$PermaAcceptDialog.dialog_text = "Make your babies more aerodynamic?"	
	$PermaAcceptDialog.visible = true


func _on_perma_dexterity_button_pressed():
	$PermaAcceptDialog.title = "DEX"	
	$PermaAcceptDialog.dialog_text = "Reload your babies faster?"
	$PermaAcceptDialog.visible = true
	
	
func _on_perma_accept_dialog_confirmed():
	match $PermaAcceptDialog.title:
		"DMG":
			print("Damage up")
			
		"SPD":
			print("spd up")
			
		"DEX":
			print("Dex up")


func _on_perma_accept_dialog_canceled():
	print("HELLA NAH")


