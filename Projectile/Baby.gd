extends RigidBody2D

var type = "projectile"
var gravity = 30  # Adjust the gravity strength
var reload_speed = 1.0
var exploding = false
var explosion = preload("res://Projectile/Explosion.tscn")
func _integrate_forces(state):
	linear_velocity += Vector2(0, gravity) * state.step
	rotation = linear_velocity.angle()  # This will orient the fireball in its movement direction

func _on_area_2d_body_entered(body):
	print("body entered")
	var explode = explosion.instantiate()
	get_tree().current_scene.add_child(explode)
	var currentPos = global_position
	explode.global_position = currentPos


func _on_area_2d_area_entered(area):
	print("body entered")
	var explode = explosion.instantiate()
	get_tree().current_scene.add_child(explode)
	var currentPos = global_position
	explode.global_position = currentPos
