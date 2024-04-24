extends Node


func change_scene(old_scene, new_scene):
	var camera = get_tree().current_scene.get_node("Camera2D")
	
	if old_scene == "combat" and new_scene == "interior":
		var trapdoor_tween = get_tree().create_tween()
		var trapdoor = get_tree().current_scene.get_node("Porch/Trapdoor")
		await trapdoor_tween.tween_property(trapdoor, "rotation_degrees", -125, 0.5).finished
		
		#var player = get_tree().current_scene.get_node("Player")
		#player.get_node("AnimationPlayer").play("combat_to_trapdoor")
		#await player.get_node("AnimationPlayer").animation_finished
		#player.get_node("AnimationPlayer").play("trapdoor_to_interior")
		#await player.get_node("AnimationPlayer").animation_finished
		
		var camera_movement_tween = get_tree().create_tween()
		var new_camera_position = get_tree().current_scene.get_node("InteriorCameraMarker").global_position
		var player_position = get_tree().current_scene.get_node("Player").global_position
		var camera_movement_duration = 1
		var new_camera_zoom = Vector2(6, 6)
		var camera_zoom_tween = get_tree().create_tween()		
		camera_movement_tween.tween_property(camera, "global_position", player_position, camera_movement_duration).set_trans(Tween.TRANS_QUAD)		
		Engine.time_scale = 0.5				
		await camera_zoom_tween.tween_property(camera, "zoom", new_camera_zoom, camera_movement_duration).finished
		camera_movement_tween.tween_property(camera, "global_position", new_camera_position, camera_movement_duration).set_trans(Tween.TRANS_QUAD)
		new_camera_zoom = Vector2(4, 4)
		camera_zoom_tween.tween_property(camera, "zoom", new_camera_zoom, camera_movement_duration)
		Engine.time_scale = 1		
		var porch_wall_transparency_tween = get_tree().create_tween()
		var porch_wall = get_tree().current_scene.get_node("Porch/PorchWall")
		var porch_wall_final_modulate = Color(1, 1, 1, 0.2)
		
		porch_wall_transparency_tween.tween_property(
			porch_wall,
			"modulate",
			porch_wall_final_modulate,
			camera_movement_duration
		)
		
		get_tree().current_scene.get_node("Porch/StartButton").visible = true
	
	if old_scene == "interior" and new_scene == "combat":
		get_tree().current_scene.get_node("Porch/StartButton").visible = false
		
		var player = get_tree().current_scene.get_node("Player")
		player.get_node("AnimationPlayer").play("interior_to_trapdoor")
		await player.get_node("AnimationPlayer").animation_finished
		player.get_node("AnimationPlayer").play("trapdoor_to_combat")
		await player.get_node("AnimationPlayer").animation_finished
		
		var trapdoor_tween = get_tree().create_tween()
		var trapdoor = get_tree().current_scene.get_node("Porch/Trapdoor")
		await trapdoor_tween.tween_property(trapdoor, "rotation_degrees", 0, 0.5).finished
		
		var camera_movement_tween = get_tree().create_tween()
		var new_camera_position = get_tree().current_scene.get_node("CombatCameraMarker").global_position
		var camera_movement_duration = 1
		camera_movement_tween.tween_property(camera, "global_position", new_camera_position, camera_movement_duration).set_trans(Tween.TRANS_QUAD)
		
		var camera_zoom_tween = get_tree().create_tween()
		var new_camera_zoom = Vector2(1.5, 1.5)
		camera_zoom_tween.tween_property(camera, "zoom", new_camera_zoom, camera_movement_duration)
		
		var porch_wall_transparency_tween = get_tree().create_tween()
		var porch_wall = get_tree().current_scene.get_node("Porch/PorchWall")
		var porch_wall_final_modulate = Color(1, 1, 1, 1)
		
		porch_wall_transparency_tween.tween_property(
			porch_wall,
			"modulate",
			porch_wall_final_modulate,
			camera_movement_duration
		)
		

