extends CanvasLayer

var skill_upgrade_options = [
	"exploding",
	"bounce",
	"multi",
	"slow",
	"enemies-spawn-less",
	"enemies-close-freeze",
	"enemies-close-damage",
	"enemies-close-slow",
	"side-gun",
	"damage-up",
	"reload-speed",
	"max-health",
	"heal-periodically",
	"charge-shot-bigger"
]
@onready var current_run_upgrades = get_tree().current_scene.get_node("Player").current_run_upgrades


var picked_skills = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# UTILITY FUNCTIONS
func randomize_options():
	randomize()
	skill_upgrade_options.shuffle()
	var selected = []
	while selected.size() <= 3:
		randomize()
		var random_index = randi() % skill_upgrade_options.size()
		if random_index not in selected:
			selected.append(random_index)
			picked_skills.append(skill_upgrade_options[random_index])
	$VBoxContainer/HBoxContainer/First.current_skill = picked_skills[0]
	$VBoxContainer/HBoxContainer/Second.current_skill = picked_skills[1]
	$VBoxContainer/HBoxContainer/Third.current_skill = picked_skills[2]
	
func reset_pick_options():
	picked_skills = []
	for upgrade in current_run_upgrades.keys():
		if current_run_upgrades[upgrade] == 7:
			print(upgrade + " is at level 5. Remove from dictionary")
			skill_upgrade_options.erase(skill_upgrade_options.find(upgrade))
# GET INPUT FROM PLAYER
func _on_firstarea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		current_run_upgrades[$VBoxContainer/HBoxContainer/First.current_skill] += 1
		get_tree().current_scene.get_node("Player").current_run_upgrades = current_run_upgrades #update player stats		
		get_tree().paused = false
		visible = false
		set_process_input(false)		


func _on_secondarea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		current_run_upgrades[$VBoxContainer/HBoxContainer/Second.current_skill] += 1		
		get_tree().current_scene.get_node("Player").current_run_upgrades = current_run_upgrades
		print(get_tree().current_scene.get_node("Player").current_run_upgrades)
		get_tree().paused = false
		visible = false		
		set_process_input(false)		

func _on_thirdarea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		current_run_upgrades[$VBoxContainer/HBoxContainer/Third.current_skill] += 1
		get_tree().current_scene.get_node("Player").current_run_upgrades = current_run_upgrades		
		get_tree().paused = false
		visible = false
		set_process_input(false)				

