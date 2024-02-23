extends Node


func change_scene(old_scene, new_scene):
	var camera = get_tree().current_scene.get_node("Camera2D")
	
	if old_scene == "combat" and new_scene == "interior":
		var camera_movement_tween = get_tree().create_tween()
		var new_camera_position = get_tree().current_scene.get_node("InteriorCameraMarker").global_position
		var camera_movement_duration = 1
		camera_movement_tween.tween_property(camera, "global_position", new_camera_position, camera_movement_duration).set_trans(Tween.TRANS_QUAD)
		
		var camera_zoom_tween = get_tree().create_tween()
		var new_camera_zoom = Vector2(4, 4)
		camera_zoom_tween.tween_property(camera, "zoom", new_camera_zoom, camera_movement_duration)
		
		var porch_wall_transparency_tween = get_tree().create_tween()
		var porch_wall = get_tree().current_scene.get_node("PorchBackground/PorchWall")
		var porch_wall_final_modulate = Color(1, 1, 1, 0.2)
		
		porch_wall_transparency_tween.tween_property(
			porch_wall,
			"modulate",
			porch_wall_final_modulate,
			camera_movement_duration
			)
