extends TextureButton

func _on_pressed():
	get_tree().current_scene.get_node("ButtonPress").play()
	disabled = true
	fade_house_track_out_and_play_combat_track()
	await SceneManager.change_scene("interior", "combat")
	GlobalVars.can_click = true
	get_tree().current_scene.start_all_timers()
	GlobalVars.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().current_scene.get_node("Player").MAX_HEALTH = 2
	GlobalVars.current_health = 2
	

func fade_house_track_out_and_play_combat_track():
	var new_tween = get_tree().create_tween()
	new_tween.tween_property(get_node("../../BGMusicHouse"), "volume_db", -100, 1)
	await new_tween.finished
	$"../../BGMusicHouse".stop()
	$"../../BGMusicCombat".volume_db = 0
	$"../../BGMusicCombat".play()
