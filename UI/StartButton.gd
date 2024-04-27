extends TextureButton




func _on_pressed():
	get_tree().current_scene.get_node("ButtonPress").play()
	disabled = true
	var new_tween = get_tree().create_tween()
	new_tween.tween_property(get_node("../../BGMusicHouse"), "volume_db", -100, 3)
	await new_tween.finished
	$"../../BGMusicHouse".stop()
	$"../../BGMusicCombat".play()
	await SceneManager.change_scene("interior", "combat")
	GlobalVars.can_click = true
	get_tree().current_scene.start_all_timers()
	GlobalVars.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().current_scene.get_node("Player").MAX_HEALTH = 1
	GlobalVars.current_health = 1
		

	
