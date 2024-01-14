extends RigidBody2D

var type = "projectile"
var gravity = 50  # Adjust the gravity strength
var reload_speed = 1.0

func _integrate_forces(state):
	linear_velocity += Vector2(0, gravity) * state.step
	rotation = linear_velocity.angle()  # This will orient the fireball in its movement direction
