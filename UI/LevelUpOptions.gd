extends CanvasLayer

var skill_upgrade_options = [
	"exploding",
	"bounce",
	"multi",
	"enemies-spawn-less",
	"enemies-close-freeze",
	"enemies-close-damage",
	"enemies-close-slow",
	"damage-up",
	"reload-speed",
	"max-health",
	"heal-periodically",
]

var skill_upgrade_icon_dict = {
	"exploding": "res://assets/ExplodingIcon.png",
	"bounce": "res://assets/BounceIcon.png", #missing
	"multi": "res://assets/MultiIcon.png",
	"enemies-spawn-less": "res://assets/EnemiesSpawnLessIcon.png", #missin
	"enemies-close-freeze": "res://assets/FreezeIcon.png",
	"enemies-close-damage": "res://assets/DamageAreaIcon.png", #missing
	"enemies-close-slow": "res://assets/SlowIcon.png",
	"damage-up": "res://assets/DamageUp.png",
	"reload-speed": "res://assets/ReloadSpeed.png",
	"max-health": "res://assets/MaxHealthIcon.png",
	"heal-periodically": "res://assets/HealPeriodically.png",
}

@onready var current_run_upgrades = get_tree().current_scene.get_node("Player").current_run_upgrades


var picked_skills = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_run_upgrades = get_tree().current_scene.get_node("Player").current_run_upgrades
		
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
	$VBoxContainer/HBoxContainer/FirstButton.current_skill = picked_skills[0]
	$VBoxContainer/HBoxContainer/FirstButton/UpgradeIcon.texture = load(skill_upgrade_icon_dict[picked_skills[0]])
	
	$VBoxContainer/HBoxContainer/SecondButton.current_skill = picked_skills[1]
	$VBoxContainer/HBoxContainer/SecondButton/UpgradeIcon.texture = load(skill_upgrade_icon_dict[picked_skills[1]])
	
	$VBoxContainer/HBoxContainer/ThirdButton.current_skill = picked_skills[2]
	$VBoxContainer/HBoxContainer/ThirdButton/UpgradeIcon.texture = load(skill_upgrade_icon_dict[picked_skills[2]])
	
func reset_pick_options():
	picked_skills = []
	for upgrade in current_run_upgrades.keys():
		if upgrade == "multi" and current_run_upgrades[upgrade] == 2 and current_run_upgrades.has(upgrade):
			print("Multi is at level 3. Remove from dictionary")			
			skill_upgrade_options.erase(upgrade)
			
		if current_run_upgrades[upgrade] == 5 and current_run_upgrades.has(upgrade):
			print(upgrade + " is at level 5. Remove from dictionary")
			if upgrade != "max-health":
				skill_upgrade_options.erase(upgrade)
			print("new upgrade array: ",skill_upgrade_options)
			
# GET INPUT FROM PLAYER
func _on_first_button_pressed():
	get_tree().current_scene.get_node("ButtonPress").play()
	current_run_upgrades[$VBoxContainer/HBoxContainer/FirstButton.current_skill] += 1
	if $VBoxContainer/HBoxContainer/FirstButton.current_skill == "max-health":
		GlobalVars.current_health += 1
		get_tree().current_scene.get_node("Player").MAX_HEALTH += 1
	if $VBoxContainer/HBoxContainer/FirstButton.current_skill == "enemies-close-freeze":
		get_tree().current_scene.get_node("Player").get_node("freeze_enemy_timer").start()
		get_tree().current_scene.get_node("FreezeCameraSprite").visible = true
	if $VBoxContainer/HBoxContainer/FirstButton.current_skill == "enemies-close-damage":
		get_tree().current_scene.get_node("Player").get_node("damage_enemy_timer").start()
	if $VBoxContainer/HBoxContainer/FirstButton.current_skill == "heal-periodically":
		get_tree().current_scene.get_node("Player").get_node("heal_timer").start()
	get_tree().current_scene.get_node("Player").current_run_upgrades = current_run_upgrades		
	reset_pick_options()
	get_tree().paused = false
	get_tree().current_scene.get_node("Billboard/Content").visible = true
	get_tree().current_scene.get_node("Billboard").z_index = -2
	get_tree().current_scene.get_node("Billboard").modulate.a = 1	
	visible = false
	set_process_input(false)				


func _on_second_button_pressed():
	get_tree().current_scene.get_node("ButtonPress").play()	
	current_run_upgrades[$VBoxContainer/HBoxContainer/SecondButton.current_skill] += 1
	if $VBoxContainer/HBoxContainer/SecondButton.current_skill == "max-health":
		print("upgrade max_health")
		GlobalVars.current_health += 1
		get_tree().current_scene.get_node("Player").MAX_HEALTH += 1
	if $VBoxContainer/HBoxContainer/SecondButton.current_skill == "enemies-close-freeze":
		get_tree().current_scene.get_node("Player").get_node("freeze_enemy_timer").start()
		get_tree().current_scene.get_node("FreezeCameraSprite").visible = true		
	if $VBoxContainer/HBoxContainer/SecondButton.current_skill == "enemies-close-damage":
		get_tree().current_scene.get_node("Player").get_node("damage_enemy_timer").start()
	if $VBoxContainer/HBoxContainer/SecondButton.current_skill == "heal-periodically":
		get_tree().current_scene.get_node("Player").get_node("heal_timer").start()
	get_tree().current_scene.get_node("Player").current_run_upgrades = current_run_upgrades		
	reset_pick_options()
	get_tree().paused = false
	get_tree().current_scene.get_node("Billboard/Content").visible = true	
	get_tree().current_scene.get_node("Billboard").z_index = -2
	get_tree().current_scene.get_node("Billboard").modulate.a = 1	
	visible = false
	set_process_input(false)				


func _on_third_button_pressed():
	get_tree().current_scene.get_node("ButtonPress").play()	
	current_run_upgrades[$VBoxContainer/HBoxContainer/ThirdButton.current_skill] += 1
	if $VBoxContainer/HBoxContainer/ThirdButton.current_skill == "max-health":
		print("upgrade max_health")
		GlobalVars.current_health += 1
		get_tree().current_scene.get_node("Player").MAX_HEALTH += 1
	if $VBoxContainer/HBoxContainer/ThirdButton.current_skill == "enemies-close-freeze":
		get_tree().current_scene.get_node("Player").get_node("freeze_enemy_timer").start()
		get_tree().current_scene.get_node("FreezeCameraSprite").visible = true
	if $VBoxContainer/HBoxContainer/ThirdButton.current_skill == "enemies-close-damage":
		get_tree().current_scene.get_node("Player").get_node("damage_enemy_timer").start()
	if $VBoxContainer/HBoxContainer/ThirdButton.current_skill == "heal-periodically":
		get_tree().current_scene.get_node("Player").get_node("heal_timer").start()
	get_tree().current_scene.get_node("Player").current_run_upgrades = current_run_upgrades		
	reset_pick_options()
	print("hello")
	get_tree().paused = false
	get_tree().current_scene.get_node("Billboard/Content").visible = true	
	get_tree().current_scene.get_node("Billboard").z_index = -2
	get_tree().current_scene.get_node("Billboard").modulate.a = 1
	visible = false
	set_process_input(false)				
