extends Node

@onready var noise = FastNoiseLite.new()
@onready var rng = RandomNumberGenerator.new()

func screenshake(magnitude):
	var camera = get_tree().current_scene.get_node("Camera2D")
	var original_position = camera.global_position
	var new_position
	
	noise.set_noise_type(0) # set to simplex noise
	
	for i in range(4):
		var tween = get_tree().create_tween()
		noise.seed = rng.randi()
		new_position = Vector2(noise.get_noise_2d(1,1), noise.get_noise_2d(1,2)) * (magnitude+1) * 10
		print(new_position)
		tween.tween_property(camera, "global_position", camera.global_position + new_position, 0.01)
		await tween.finished
		tween.kill()
	
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position", original_position, 0.2)
	await tween.finished
	tween.kill()
		
	return self
