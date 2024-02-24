extends Node2D
var current_projectile = preload("res://Projectile/Baby.tscn")
var freeze_area = preload("res://Projectile/FreezeArea.tscn")
var damage_area = preload("res://Projectile/DamageArea.tscn")
var slow_area = preload("res://Projectile/SlowAura.tscn")
var current_exp = 0
var type = "player"
var can_shoot: bool = true
var exploding: bool = false
var multi:bool = false
var slow:bool = false
var slow_aoe
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
}

var enemies_spawn_less_options = [1,0.95,0.9,0.85,0.8,0.75]
var spawn_less_index
var freeze_enemy_timer_options = [0,3,2.2,1.7,1.5,1]
var damage_enemy_timer_options = [0,3,2.2,1.7,1.5,1]
var slow_enemy_options = [1,0.6,0.5,0.4,0.3,0.2]
var damage_up_options = [0,0.5,1,1.5,2,2.5]
var reload_speed_options = [1,0.95,0.9,0.87,0.82,0.75]

@onready var spawn_freeze_aoe = $freeze_enemy_timer
@onready var spawn_damage_aoe = $damage_enemy_timer
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
	if not slow:
		if current_run_upgrades["enemies-close-slow"]:
			slow_aoe = slow_area.instantiate()
			add_child(slow_aoe)
			slow_aoe.global_position = global_position
			slow = true
	spawn_less_index = current_run_upgrades["enemies-spawn-less"]
	GlobalVars.spawn_less_multiplier = enemies_spawn_less_options[spawn_less_index]
	if current_run_upgrades["reload-speed"] > 0:
		reload_timer.wait_time = reload_speed_options[current_run_upgrades["reload-speed"]]
	if current_run_upgrades["enemies-close-freeze"] > 0:
		spawn_freeze_aoe.wait_time = freeze_enemy_timer_options[current_run_upgrades["enemies-close-freeze"]]
	if current_run_upgrades["enemies-close-damage"] > 0:
		spawn_damage_aoe.wait_time = damage_enemy_timer_options[current_run_upgrades["enemies-close-damage"]]
	if current_run_upgrades["enemies-close-slow"] > 0:
		slow_aoe.slow_multiplier = slow_enemy_options[current_run_upgrades["enemies-close-slow"]]
	
func point_head_to_mouse():
	var mouse_pos = get_global_mouse_position()  # Get the global position of the mouse cursor
	var direction = (mouse_pos - global_position).normalized()  # Calculate the direction to the cursor
	var angle = atan2(direction.y, direction.x)  # Calculate the angle in radians

func _input(event):
	if can_shoot and Input.is_action_pressed("shoot"):
		shoot_projectile()

func shoot_projectile():
	var baby = current_projectile.instantiate()	
	if current_run_upgrades["damage-up"] > 0:
		baby.damage = baby.initial_damage + damage_up_options[current_run_upgrades["damage-up"]]
	if current_run_upgrades["bounce"] > 0:
		baby.bounce = current_run_upgrades["bounce"]
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
		if current_run_upgrades["bounce"] > 0:
			baby.bounce = current_run_upgrades["bounce"]
		if current_run_upgrades["damage-up"] > 0:
			baby.damage = baby.initial_damage + damage_up_options[current_run_upgrades["damage-up"]]
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
		if current_run_upgrades["damage-up"] > 0:
			baby.damage = baby.initial_damage + damage_up_options[current_run_upgrades["damage-up"]]
		if current_run_upgrades["bounce"] > 0:
			baby.bounce = current_run_upgrades["bounce"]
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

func _on_freeze_enemy_timer_timeout():
	var freeze_aoe = freeze_area.instantiate()
	add_child(freeze_aoe)
	freeze_aoe.global_position = $ProjectilePos.global_position
	
func _on_damage_enemy_timer_timeout():
	var damage_aoe = damage_area.instantiate()
	add_child(damage_aoe)
	damage_aoe.global_position = $ProjectilePos.global_position
