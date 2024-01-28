extends Node2D
var current_projectile = preload("res://Projectile/Baby.tscn")
var current_exp = 0
var type = "player"
@onready var reload_timer = $reload_timer
var can_shoot: bool = true
@export var MAX_HEALTH = 10

func _ready():
	var baby = current_projectile.instantiate()
	var get_reload_speed = baby.reload_speed
	reload_timer.wait_time = get_reload_speed
	GlobalVars.current_health = MAX_HEALTH

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
	GlobalVars.current_health -= damage
	if GlobalVars.current_health == 0:
		print("you lose")
		self.queue_free()
	
func _on_hitbox_body_entered(body):
	get_hit(body.damage)
	body.queue_free()
