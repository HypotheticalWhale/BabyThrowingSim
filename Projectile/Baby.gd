extends RigidBody2D

var type = "projectile"
var gravity = 5  # Adjust the gravity strength
var reload_speed = 1.0

var exploding = 0

var damage = 1
var explosion_scene = preload("res://Projectile/Explosion.tscn")
var damage_number_scene = preload("res://Enemy/DamageNumber.tscn")

func _integrate_forces(state):
	linear_velocity += Vector2(0, gravity) * state.step
	rotation = linear_velocity.angle()  # This will orient the fireball in its movement direction

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
