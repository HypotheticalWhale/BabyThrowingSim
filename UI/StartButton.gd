extends TextureButton




func _on_pressed():
	await SceneManager.change_scene("interior", "combat")
	get_tree().current_scene.start_all_timers()
	
	GlobalVars.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().current_scene.get_node("Player").MAX_HEALTH = 1
	GlobalVars.current_health = 1
		

	
