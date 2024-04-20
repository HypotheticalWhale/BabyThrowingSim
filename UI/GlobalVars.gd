extends Node

var id = "GlobalVars"
var current_exp = 0
var current_health = 0
var current_money = 0
var current_level:int = 0
var highscore:int = 0
var exp_to_next_level:int = 5
var spawn_less_multiplier = 0

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_if_player_levels()
	if GlobalVars.current_health <= 0:
		print("You went insane... going home to take a break")
		SceneManager.change_scene("combat", "interior")
		get_tree().current_scene.kill_all_dads()
		get_tree().current_scene.stop_all_timers()
		reset_all_stats()
		process_mode = Node.PROCESS_MODE_DISABLED
		
func reset_all_stats():
	if current_level > highscore:
		var highscore_label = get_tree().current_scene.get_node("InGameOverlay/TopLeftContainer/HighscoreMargin/HighscoreContainer/CurrentHighscore")
		highscore_label.modulate = Color(0,255,0)
		await get_tree().create_timer(5).timeout
		highscore_label.modulate = Color(255,255,255)
		highscore = current_level

	current_exp = 0
	current_health = 0
	current_level = 0
	exp_to_next_level = 5
	spawn_less_multiplier = 0
	get_tree().current_scene.get_node("Player").MAX_HEALTH = 1
	get_tree().current_scene.get_node("Player").reset_upgrades()
	print(get_tree().current_scene.get_node("Player").current_run_upgrades)
	get_tree().current_scene.get_node("FreezeCameraSprite").visible = false
	
	SaveAndLoad.save_game()

	
func check_if_player_levels():
	if current_exp >= exp_to_next_level:
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


func save():
	var save_dict = {
		"id":id,
		"highscore":highscore
	}
	return save_dict
