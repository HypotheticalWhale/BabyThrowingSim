extends Node2D
var moveAmount := 0.1
@onready var timer = $Timer
func _process(delta):
	move_up()

func move_up():
	var currentPos = global_position
	print(currentPos)
	currentPos.y -= moveAmount
	print(currentPos)
	global_position = currentPos

func _on_timer_timeout():
	self.queue_free()
