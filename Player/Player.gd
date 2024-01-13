extends Node2D

# Exposed variables
@export var projectile_scene: PackedScene
@export var arc_height: float = 100.0  # Adjust this value to control the height of the arc
var projectile_speed: float = 5.0
var direction: Vector2

# Called every frame
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var mouse_position: Vector2 = get_global_mouse_position()
		var projectile_instance: Node2D = projectile_scene.instantiate()
		projectile_instance.global_position = global_position
		direction = (mouse_position - global_position).normalized()
		var time_to_target: float = direction.length() / projectile_speed
		var initial_velocity_x: float = direction.x * projectile_speed
		var initial_velocity_y: float = (direction.y * projectile_speed) + (0.5 * arc_height * 9.8 * time_to_target)
		# Set the projectile's initial velocity
		projectile_instance.velocity = Vector2(initial_velocity_x, initial_velocity_y)
		get_parent().add_child(projectile_instance)

