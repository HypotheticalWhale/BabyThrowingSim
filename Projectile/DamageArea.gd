extends Node2D
var type = "damage_area"
var damage = 1
var damage_number_scene = preload("res://Enemy/DamageNumber.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("play")
	await get_tree().create_timer(0.5).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	self.queue_free()

func _on_area_2d_area_entered(area):
	pass

func _on_area_2d_body_entered(body):
	pass
