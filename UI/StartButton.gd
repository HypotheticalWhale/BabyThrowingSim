extends TextureButton




func _on_pressed():
	await SceneManager.change_scene("interior", "combat")
	
