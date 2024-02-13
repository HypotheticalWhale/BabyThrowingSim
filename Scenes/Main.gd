extends Node2D
@export var spawn_reg_dad: bool# Adjust this value to set the spawn interval in seconds
@onready var regular_dad = preload("res://Enemy/RegularDad/RegularDad.tscn")
var regular_dad_spawn_timer
var type = "main"
# Called when the node enters the scene tree for the first time.
func _ready():
	var reg_dad = regular_dad.instantiate()
	var regular_dad_spawn_interval = reg_dad.spawn_interval
	if spawn_reg_dad:
		start_timer(regular_dad_spawn_interval,"regular_dad")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_timer(spawn_interval, typeofdad):
	if typeofdad == "regular_dad":
		regular_dad_spawn_timer = Timer.new()
		regular_dad_spawn_timer.one_shot = false
		regular_dad_spawn_timer.wait_time = spawn_interval
		add_child(regular_dad_spawn_timer)
		regular_dad_spawn_timer.timeout.connect(_on_regdad_spawn_timer_timeout)
		regular_dad_spawn_timer.start()
		return
		
func _on_regdad_spawn_timer_timeout() -> void:
	var reg_dad = regular_dad.instantiate()
	reg_dad.global_position = $Marker2D.global_position
	add_child(reg_dad)
