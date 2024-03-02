extends Sprite2D


func _on_perma_damage_button_pressed():
	$PermaAcceptDialog.visible = true


func _on_perma_accept_dialog_confirmed():
	print("HELLA YEAH")


func _on_perma_accept_dialog_canceled():
	print("HELLA NAH")
