extends Node2D
var type = "slow_aura"
var slow_multiplier = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("wow_trippy")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
