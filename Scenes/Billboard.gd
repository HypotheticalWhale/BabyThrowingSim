extends Sprite2D
@onready var texture1 = preload("res://assets/BillboardContent.png")
@onready var texture2 = preload("res://assets/BillboardContent2.png")
var all_textures = [texture1,texture2]
var current_index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_next_item():
	print(all_textures[current_index])
	current_index += 1
	if current_index >= all_textures.size():
		current_index = 0

func _on_change_content_timer_timeout():
	if texture == texture1:
		texture = texture2
	else:
		texture = texture1
