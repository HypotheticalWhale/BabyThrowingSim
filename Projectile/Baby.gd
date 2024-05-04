extends RigidBody2D

var type = "projectile"
var gravity = 5  # Adjust the gravity strength
var reload_speed = 1.0

var poopy_diaper = 0
var bouncy = 0
var initial_damage = 1
var speed = 1
var gravity_vector
var damage = 1
var bouncyd = 0
var explosion_scene = preload("res://Projectile/Explosion.tscn")
var damage_number_scene = preload("res://Enemy/DamageNumber.tscn")
var allowed_time_to_bouncy_options = [0,3,6,9,12,15]


func _integrate_forces(state):
	gravity_vector = Vector2(0, gravity) * speed
	linear_velocity += gravity_vector * state.step
	rotation = linear_velocity.angle()  # This will orient the fireball in its movement direction
	
	if bouncy >= 1:
		var camera_size = get_viewport_rect().size * get_tree().current_scene.get_node("Camera2D").zoom
		var camera_rect = Rect2(get_tree().current_scene.get_node("Camera2D").get_target_position() - camera_size / 2, camera_size)
		# Check collision with the left and right boundaries
		if global_position.x < 0 or global_position.x > 850:
			if bouncyd > allowed_time_to_bouncy_options[bouncy]:
				self.queue_free()
			bouncyd += 1
			linear_velocity.x *= -1
		
		# Check collision with the top and bottom boundaries
		if global_position.y < 0 or global_position.y > 450:
			if bouncyd > allowed_time_to_bouncy_options[bouncy]:
				self.queue_free()
			bouncyd += 1
			linear_velocity.y *= -1


func _on_area_2d_body_entered(body):
	var currentPos = global_position
	if poopy_diaper >= 1:
		var explode = explosion_scene.instantiate()
		explode.level = poopy_diaper		
		get_tree().current_scene.add_child(explode)
		explode.global_position = currentPos


func _on_area_2d_area_entered(area):
	var currentPos = global_position
	if poopy_diaper >= 1:
		get_tree().current_scene.get_node("ExplodingSound").play()
		var explode = explosion_scene.instantiate()
		explode.level = poopy_diaper		
		get_tree().current_scene.add_child(explode)
		explode.global_position = currentPos


func _on_expire_timer_timeout():
	self.queue_free()
