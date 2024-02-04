extends CharacterBody2D

# Exposed variables
@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.LEFT  # Adjust the direction as needed
@export var spawn_interval: float = 2.0
@export var damage: int = 1
@export var exp:int = 1
@export var monry_drop_rate: float = 0.4
var you_got_cash = preload("res://Enemy/DollarSign.tscn")

func _ready():
	velocity = direction * speed

func _process(delta: float) -> void:
	move_and_slide()
	if velocity == Vector2.ZERO:
		await get_tree().create_timer(2.0).timeout
		self.queue_free()

func _on_hurtbox_body_entered(body):
	self.queue_free()


func _on_hurtbox_area_entered(area):	
	if area.type == "projectile":
		GlobalVars.current_exp += exp
		var randomValue := randf()
		if randomValue <= monry_drop_rate:
			var give_player_money = you_got_cash.instantiate()
			get_tree().current_scene.add_child(give_player_money)
			give_player_money.global_position = global_position
			GlobalVars.current_money += 1
	elif not area.owner.type == "player":
		GlobalVars.current_exp += exp
		var randomValue := randf()
		if randomValue <= monry_drop_rate:
			var give_player_money = you_got_cash.instantiate()
			get_tree().current_scene.add_child(give_player_money)
			give_player_money.global_position = global_position
			GlobalVars.current_money += 1
	self.queue_free()
