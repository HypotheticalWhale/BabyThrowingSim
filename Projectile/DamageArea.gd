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
	var damage_number = damage_number_scene.instantiate()
	var currentPos = global_position
	var shiftedPos = Vector2(currentPos.x + 1, currentPos.y)	
	get_tree().current_scene.add_child(damage_number)
	damage_number.global_position = shiftedPos
	damage_number.get_child(0).text = str(damage)# Replace with function body.
	

func _on_area_2d_body_entered(body):
	var damage_number = damage_number_scene.instantiate()
	var currentPos = global_position
	var shiftedPos = Vector2(currentPos.x + 1, currentPos.y)	
	get_tree().current_scene.add_child(damage_number)
	damage_number.global_position = shiftedPos
	damage_number.get_child(0).text = str(damage)
