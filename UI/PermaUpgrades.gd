extends Node
var dmg_upgrade = 0
var spd_upgrade = 0
var reload_upgrade = 0 
var dmg_lvl = 0
var spd_lvl = 0
var reload_lvl = 0 
var dmg_upgrade_options = [1,1.5,2,2.5]
var spd_upgrade_options = [1,1.5,2,2.5]
var reload_upgrade_options = [1,0.9,0.8,0.7]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dmg_upgrade = dmg_upgrade_options[dmg_lvl]
	spd_upgrade = spd_upgrade_options[spd_lvl]
	reload_upgrade = reload_upgrade_options[reload_lvl]
	
