extends Node2D
var moveAmount := 0.1
@onready var timer = $Timer

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
	move_up()

func move_up():
	var currentPos = global_position
	currentPos.y -= moveAmount
	global_position = currentPos

func _on_timer_timeout():
	self.queue_free()
