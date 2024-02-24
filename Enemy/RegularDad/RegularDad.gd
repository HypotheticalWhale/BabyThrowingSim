extends CharacterBody2D

# Exposed variables
@export var initial_speed: float = 200.0
@export var direction: Vector2 = Vector2.LEFT  # Adjust the direction as needed
@export var spawn_interval: float = 2.0
@export var damage: int = 1
@export var exp:int = 1
@export var money_drop_rate: float = 0.4
@export var MAX_HP:int = 1
@export var current_hp:int = 1
var speed

var you_got_cash = preload("res://Enemy/DollarSign.tscn")

func _ready():
	speed = initial_speed
	$AnimationPlayer.play("walk_left")
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	spawn_interval = 2.0 * GlobalVars.spawn_less_multiplier
	move_and_slide()

func get_hit(damage):
	current_hp -= damage
	if current_hp <= 0:
		self.queue_free()
		
func _on_hurtbox_body_entered(body):
	self.queue_free()

func _on_hurtbox_area_entered(area):
	if area.owner.type == "slow_aura":
		speed = initial_speed * area.owner.slow_multiplier
		velocity = direction * speed
	if area.owner.type == "damage_area":
		get_hit(area.owner.damage)
		GlobalVars.current_exp += exp
		var randomValue := randf()
		if randomValue <= money_drop_rate:
			var give_player_money = you_got_cash.instantiate()
			get_tree().current_scene.add_child(give_player_money)
			give_player_money.global_position = global_position
			GlobalVars.current_money += 1
	if area.owner.type == "freeze_area":
		velocity = Vector2(0,0)
		await get_tree().create_timer(1.0).timeout
		velocity = direction * speed
	elif not area.owner.type == "player":
		get_hit(area.owner.damage)
		GlobalVars.current_exp += exp
		var randomValue := randf()
		if randomValue <= money_drop_rate:
			var give_player_money = you_got_cash.instantiate()
			get_tree().current_scene.add_child(give_player_money)
			give_player_money.global_position = global_position
			GlobalVars.current_money += 1
