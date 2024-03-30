extends Node2D
@export var spawn_reg_dad: bool# Adjust this value to set whether or not dad spawns
@export var spawn_tough_dad: bool
@export var spawn_flying_dad:bool
@export var spawn_drunk_dad:bool

@onready var regular_dad = preload("res://Enemy/RegularDad/RegularDad.tscn")
@onready var tough_dad = preload("res://Enemy/ToughDad/ToughDad.tscn")
@onready var flying_dad = preload("res://Enemy/FlyingDad/FlyingDad.tscn")
@onready var drunk_dad = preload("res://Enemy/DrunkDad/DrunkDad.tscn")

var myass
var regular_dad_spawn_timer
var tough_dad_spawn_timer
var flying_dad_spawn_timer
var drunk_dad_spawn_timer

var type = "main"
var enemies = []
var spawn_timers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var reg_dad = regular_dad.instantiate()
	var regular_dad_spawn_interval = reg_dad.spawn_interval
	var tog_dad = tough_dad.instantiate()
	var tough_dad_spawn_interval = tog_dad.spawn_interval
	var fly_dad = flying_dad.instantiate()
	var flying_dad_spawn_interval = fly_dad.spawn_interval
	var drunked_dad = drunk_dad.instantiate()
	var drunk_dad_spawn_interval = drunked_dad.spawn_interval
	if spawn_reg_dad:
		start_timer(regular_dad_spawn_interval,"regular_dad")
	if spawn_tough_dad:
		start_timer(tough_dad_spawn_interval,"tough_dad")
	if spawn_flying_dad:
		start_timer(flying_dad_spawn_interval,"flying_dad")
	if spawn_drunk_dad:
		start_timer(drunk_dad_spawn_interval,"drunk_dad")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 
func start_timer(spawn_interval, typeofdad):
	if typeofdad == "regular_dad":
		regular_dad_spawn_timer = Timer.new()
		regular_dad_spawn_timer.one_shot = false
		regular_dad_spawn_timer.wait_time = spawn_interval
		add_child(regular_dad_spawn_timer)
		spawn_timers.append(regular_dad_spawn_timer)
		regular_dad_spawn_timer.timeout.connect(_on_regdad_spawn_timer_timeout)
		regular_dad_spawn_timer.start()
		return
	if typeofdad == "tough_dad":
		tough_dad_spawn_timer = Timer.new()
		tough_dad_spawn_timer.one_shot = false
		tough_dad_spawn_timer.wait_time = spawn_interval
		add_child(tough_dad_spawn_timer)
		spawn_timers.append(tough_dad_spawn_timer)
		
		tough_dad_spawn_timer.timeout.connect(_on_toughdad_spawn_timer_timeout)
		tough_dad_spawn_timer.start()
		return
		
	if typeofdad == "flying_dad":
		flying_dad_spawn_timer = Timer.new()
		flying_dad_spawn_timer.one_shot = false
		flying_dad_spawn_timer.wait_time = spawn_interval
		add_child(flying_dad_spawn_timer)
		spawn_timers.append(flying_dad_spawn_timer)
		flying_dad_spawn_timer.timeout.connect(_on_flyingdad_spawn_timer_timeout)
		flying_dad_spawn_timer.start()
		return
		
	if typeofdad == "drunk_dad":
		drunk_dad_spawn_timer = Timer.new()
		drunk_dad_spawn_timer.one_shot = false
		drunk_dad_spawn_timer.wait_time = spawn_interval
		add_child(drunk_dad_spawn_timer)
		spawn_timers.append(drunk_dad_spawn_timer)
		drunk_dad_spawn_timer.timeout.connect(_on_drunkdad_spawn_timer_timeout)
		drunk_dad_spawn_timer.start()
		return
		
func kill_all_dads():
	for i in range(1, enemies.size()):
		if enemies[i] != null:
			enemies[i].queue_free()
	enemies = []
	
func stop_all_timers():
	for timer in spawn_timers:
		timer.stop()
	spawn_timers = []
	get_tree().current_scene.get_node("StartSpawningRegularTimer").stop()
	get_tree().current_scene.get_node("StartSpawningToughTimer").stop()
	get_tree().current_scene.get_node("StartSpawningFlyingTimer").stop()
	get_tree().current_scene.get_node("StartSpawningDrunkTimer").stop()
	
func start_all_timers():
	get_tree().current_scene.get_node("StartSpawningRegularTimer").start()
	get_tree().current_scene.get_node("StartSpawningToughTimer").start()
	get_tree().current_scene.get_node("StartSpawningFlyingTimer").start()
	get_tree().current_scene.get_node("StartSpawningDrunkTimer").start()
		
func _on_regdad_spawn_timer_timeout() -> void:
	var reg_dad = regular_dad.instantiate()
	reg_dad.global_position = $Marker2D.global_position
	add_child(reg_dad)
	enemies.append(reg_dad)

func _on_toughdad_spawn_timer_timeout() -> void:
	var tog_dad = tough_dad.instantiate()
	tog_dad.global_position = $Marker2D.global_position
	add_child(tog_dad)
	enemies.append(tog_dad)

func _on_flyingdad_spawn_timer_timeout() -> void:
	var fly_dad = flying_dad.instantiate()
	fly_dad.global_position = $FlyingMarker2D.global_position
	add_child(fly_dad)
	enemies.append(fly_dad)
	
func _on_drunkdad_spawn_timer_timeout() -> void:
	var drunked_dad = drunk_dad.instantiate()
	drunked_dad.global_position = $Marker2D.global_position
	add_child(drunked_dad)
	enemies.append(drunked_dad)


func _on_start_spawning_regular_timer_timeout():
	var reg_dad = regular_dad.instantiate()
	var regular_dad_spawn_interval = reg_dad.spawn_interval
	start_timer(regular_dad_spawn_interval,"regular_dad")


func _on_start_spawning_tough_timer_timeout():
	var tog_dad = tough_dad.instantiate()
	var tough_dad_spawn_interval = tog_dad.spawn_interval
	start_timer(tough_dad_spawn_interval,"tough_dad")


func _on_start_spawning_flying_timer_timeout():
	var fly_dad = flying_dad.instantiate()
	var flying_dad_spawn_interval = fly_dad.spawn_interval
	start_timer(flying_dad_spawn_interval,"flying_dad")


func _on_start_spawning_drunk_timer_timeout():
	var drunked_dad = drunk_dad.instantiate()
	var drunk_dad_spawn_interval = drunked_dad.spawn_interval
	start_timer(drunk_dad_spawn_interval,"drunk_dad")
