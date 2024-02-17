extends Node2D
var current_projectile = preload("res://Projectile/Baby.tscn")
var current_exp = 0
var type = "player"
var can_shoot: bool = true
var exploding: bool = false
var multi:bool = false
signal gameover

var current_run_upgrades = {
	"exploding":0,
	"bounce":0,
	"multi":0,
	"enemies-spawn-less":0,
	"enemies-close-freeze":0,
	"enemies-close-damage":0,
	"enemies-close-slow":0,
	"side-gun":0,
	"damage-up":0,
	"reload-speed":0,
	"max-health":0,
	"heal-periodically":0,
	"charge-shot-bigger":0
}
var enemies_spawn_less_options = [1,0.95,0.9,0.85,0.8,0.75]
@onready var reload_timer = $reload_timer
@export var MAX_HEALTH = 1

func _ready():
	var baby = current_projectile.instantiate()
	var get_reload_speed = baby.reload_speed
	reload_timer.wait_time = get_reload_speed
	GlobalVars.current_health = MAX_HEALTH

func _physics_process(delta):
	point_head_to_mouse()
	if not exploding:
		if current_run_upgrades["exploding"] >= 1:
			exploding = true
	if not multi:
		if current_run_upgrades["multi"] >= 1:
			multi = true
	current_run_upgrades["enemies-spawn-less"]
func point_head_to_mouse():
	var mouse_pos = get_global_mouse_position()  # Get the global position of the mouse cursor
	var direction = (mouse_pos - global_position).normalized()  # Calculate the direction to the cursor
	var angle = atan2(direction.y, direction.x)  # Calculate the angle in radians

func _input(event):
	if can_shoot and Input.is_action_pressed("shoot"):
		shoot_projectile()

func shoot_projectile():
	var baby = current_projectile.instantiate()
	if exploding:
		baby.exploding = current_run_upgrades["exploding"]
	add_child(baby)
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - baby.global_position).normalized()
	var initial_speed = 700  # Set your desired speed
	baby.linear_velocity = direction * initial_speed
	# Set cooldown timer for shooting
	can_shoot = false
	reload_timer.start()
	if current_run_upgrades["multi"] >= 1 and multi:
		var shiftedPos = Vector2(global_position.x, global_position.y+10)
		baby.global_position = shiftedPos
		baby = current_projectile.instantiate()
		if exploding:
			baby.exploding = current_run_upgrades["exploding"]
		add_child(baby)
		mouse_pos = get_global_mouse_position()
		direction = (mouse_pos - baby.global_position).normalized()
		initial_speed = 900  # Set your desired speed
		baby.linear_velocity = direction * initial_speed
		baby.gravity = 3
		# Set cooldown timer for shooting
		can_shoot = false
		reload_timer.start()
	if current_run_upgrades["multi"] == 2 and multi:
		var shiftedPos = Vector2(global_position.x, global_position.y-10)
		baby.global_position = shiftedPos
		baby = current_projectile.instantiate()
		if exploding:
			baby.exploding = current_run_upgrades["exploding"]
		add_child(baby)
		mouse_pos = get_global_mouse_position()
		direction = (mouse_pos - baby.global_position).normalized()
		initial_speed = 600  # Set your desired speed
		baby.linear_velocity = direction * initial_speed
		baby.gravity = 7		
		# Set cooldown timer for shooting
		can_shoot = false
		reload_timer.start()
			
func get_hit(damage):
	GlobalVars.current_health -= damage
	if GlobalVars.current_health == 0:
		emit_signal("gameover")
		print("You went insane... going home to take a break")
		SceneManager.change_scene("combat", "interior")
		
func _on_reload_timer_timeout():
	can_shoot = true

	
func _on_hitbox_body_entered(body):
	get_hit(body.damage)
	body.queue_free()

