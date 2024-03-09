extends RigidBody2D

var type = "projectile"
var gravity = 5  # Adjust the gravity strength
var reload_speed = 1.0

var exploding = 0
var bounce = 0
var initial_damage = 1
var speed = 1
var gravity_vector
var damage = 1
var bounced = 0
var explosion_scene = preload("res://Projectile/Explosion.tscn")
var damage_number_scene = preload("res://Enemy/DamageNumber.tscn")
var allowed_time_to_bounce_options = [0,3,6,9,12,15]

func _ready():
	damage = initial_damage

func _integrate_forces(state):
	gravity_vector = Vector2(0, gravity) * speed
	linear_velocity += gravity_vector * state.step
	rotation = linear_velocity.angle()  # This will orient the fireball in its movement direction
	
	if bounce >= 1:
		var camera_size = get_viewport_rect().size * get_tree().current_scene.get_node("Camera2D").zoom
		var camera_rect = Rect2(get_tree().current_scene.get_node("Camera2D").get_target_position() - camera_size / 2, camera_size)
		# Check collision with the left and right boundaries
		if global_position.x < 0 or global_position.x > 850:
			if bounced > allowed_time_to_bounce_options[bounce]:
				self.queue_free()
			bounced += 1
			linear_velocity.x *= -1
		
		# Check collision with the top and bottom boundaries
		if global_position.y < 0 or global_position.y > 450:
			if bounced > allowed_time_to_bounce_options[bounce]:
				self.queue_free()
			bounced += 1
			linear_velocity.y *= -1


func _on_area_2d_body_entered(body):
	var damage_number = damage_number_scene.instantiate()
	var currentPos = global_position
	var shiftedPos = Vector2(currentPos.x + 1, currentPos.y)
	get_tree().current_scene.add_child(damage_number)
	damage_number.global_position = shiftedPos
	damage_number.get_child(0).text = str(damage)
	if exploding >= 1:
		var explode = explosion_scene.instantiate()
		explode.level = exploding		
		get_tree().current_scene.add_child(explode)
		explode.global_position = currentPos


func _on_area_2d_area_entered(area):
	var damage_number = damage_number_scene.instantiate()
	var currentPos = global_position
	var shiftedPos = Vector2(currentPos.x + 1, currentPos.y)	
	get_tree().current_scene.add_child(damage_number)
	damage_number.global_position = shiftedPos
	damage_number.get_child(0).text = str(damage)
	if exploding >= 1:
		var explode = explosion_scene.instantiate()
		explode.level = exploding
		get_tree().current_scene.add_child(explode)
		explode.global_position = currentPos


func _on_expire_timer_timeout():
	self.queue_free()
