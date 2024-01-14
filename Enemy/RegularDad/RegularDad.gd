extends CharacterBody2D

# Exposed variables
@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.LEFT  # Adjust the direction as needed
@export var spawn_interval: float = 2.0
@export var damage: int = 1

func _ready():
	velocity = direction * speed

func _process(delta: float) -> void:
	move_and_slide()


func _on_hurtbox_body_entered(body):
	self.queue_free()
