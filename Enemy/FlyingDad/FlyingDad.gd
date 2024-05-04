extends CharacterBody2D

# Exposed variables
@export var initial_speed: float = 100.0
@export var direction: Vector2 = Vector2.LEFT  # Adjust the direction as needed
@export var spawn_interval: float = 5
@export var damage: int = 1
@export var exp:int = 1
@export var money_drop_rate: float = 0.4
@export var MAX_HP = 2.0
@export var current_hp = 2.0
var speed

var you_got_cash = preload("res://Enemy/DollarSign.tscn")
var damage_number_scene = preload("res://Enemy/DamageNumber.tscn")
func _ready():
	$AnimationPlayer.play("walk_left")
	speed = initial_speed
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	spawn_interval = 2.0 * GlobalVars.spawn_less_multiplier
	move_and_slide()

func get_hit(damage):
	VFX.screenshake(damage-1)
	current_hp -= damage
	var damage_number = damage_number_scene.instantiate()
	var currentPos = global_position
	var shiftedPos = Vector2(currentPos.x + 1, currentPos.y)	
	get_tree().current_scene.add_child(damage_number)
	damage_number.global_position = shiftedPos
	damage_number.get_child(0).text = str(damage)
	if current_hp <= 0:
		get_tree().current_scene.get_node("BasicDadDieSound").play()
		GlobalVars.current_exp += exp
		var randomValue := randf()
		if randomValue <= money_drop_rate:
			var give_player_money = you_got_cash.instantiate()
			get_tree().current_scene.add_child(give_player_money)
			give_player_money.global_position = global_position
			GlobalVars.current_money += 1
		self.queue_free()
		
func _on_hurtbox_body_entered(body):
	self.queue_free()

func _on_hurtbox_area_entered(area):
	if area.owner.type == "slow_aura":
		speed = initial_speed * area.owner.slow_multiplier
		velocity = direction * speed
		return
	if area.owner.type == "damage_area":
		get_hit(area.owner.damage)
		return
	if area.owner.type == "freeze_area":
		velocity = Vector2(0,0)
		await get_tree().create_timer(1.0).timeout
		velocity = direction * speed
		return
	if area.owner.type == "projectile":
		get_hit(area.owner.damage)
		return 
