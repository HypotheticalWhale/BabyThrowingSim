extends Node

var current_exp = 0
var current_health = 0
var current_money = 0
var current_level:int = 0
var exp_to_next_level:int = 1

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_if_player_levels()


func check_if_player_levels():
	if current_exp == exp_to_next_level:
		current_level += 1
		level_up()
		exp_to_next_level *= 2
		current_exp = 0
		get_tree().paused = true

func level_up():
	var level_up_options = get_tree().current_scene.get_node("LevelUpOptions")
	get_tree().current_scene.get_node("Billboard/Content").visible = false
	level_up_options.show()
	level_up_options.randomize_options()
	level_up_options.set_process_input(true)
