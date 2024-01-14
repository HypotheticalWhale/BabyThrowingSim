#extends Node2D
#
## Exposed variables
#@export var projectile_scene: PackedScene
#@export var arc_height: float = 100.0  # Adjust this value to control the height of the arc
#var projectile_speed: float = 5.0
#var direction: Vector2
#
## Called every frame
#func _process(delta: float) -> void:
	#if Input.is_action_pressed("shoot"):
		#var mouse_position: Vector2 = get_global_mouse_position()
		#var projectile_instance: Node2D = projectile_scene.instantiate()
		#projectile_instance.global_position = global_position
		#direction = (mouse_position - global_position).normalized()
		#var time_to_target: float = direction.length() / projectile_speed
		#var initial_velocity_x: float = direction.x * projectile_speed
		#var initial_velocity_y: float = (direction.y * projectile_speed) + (0.5 * arc_height * 9.8 * time_to_target)
		## Set the projectile's initial velocity
		#projectile_instance.velocity = Vector2(initial_velocity_x, initial_velocity_y)
		#get_parent().add_child(projectile_instance)

extends Node2D

var current_projectile = preload("res://Projectile/Baby.tscn")
@onready var reload_timer = $reload_timer
var can_shoot: bool = true
var MAX_HEALTH = 10
var current_health = 10

func _ready():
	var baby = current_projectile.instantiate()
	var get_reload_speed = baby.reload_speed
	reload_timer.wait_time = get_reload_speed

func _physics_process(delta):
	point_head_to_mouse()

func point_head_to_mouse():
	var mouse_pos = get_global_mouse_position()  # Get the global position of the mouse cursor
	var direction = (mouse_pos - global_position).normalized()  # Calculate the direction to the cursor
	var angle = atan2(direction.y, direction.x)  # Calculate the angle in radians

func _input(event):
	if can_shoot and Input.is_action_pressed("shoot"):
		shoot_projectile()

func shoot_projectile():
	var baby = current_projectile.instantiate()
	add_child(baby)
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - baby.global_position).normalized()
	var initial_speed = 700  # Set your desired speed
	baby.linear_velocity = direction * initial_speed
	# Set cooldown timer for shooting
	can_shoot = false
	reload_timer.start()
	
func _on_reload_timer_timeout():
	can_shoot = true

func get_hit(damage):
	current_health = current_health - damage
	if current_health == 0:
		print("you lose")
		self.queue_free()
	
func _on_hitbox_body_entered(body):
	get_hit(body.damage)
	body.queue_free()
