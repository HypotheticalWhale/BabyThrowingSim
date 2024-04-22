extends ProgressBar
var current_exp
var exp_to_next_level
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_exp = GlobalVars.current_exp
	exp_to_next_level = GlobalVars.exp_to_next_level
	value = current_exp
	max_value = exp_to_next_level
