extends Sprite2D
@onready var texture1 = preload("res://assets/BillboardContent.png")
@onready var texture2 = preload("res://assets/BillboardContent2.png")
@onready var texture3 = preload("res://assets/BillboardContent3.png")
@onready var all_textures = [texture1,texture2,texture3]
var current_index = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_next_item():
	current_index += 1
	if current_index >= all_textures.size():
		current_index = 0
	print(all_textures)
	return all_textures[current_index]
	
func _on_change_content_timer_timeout():
	print(get_next_item())
	texture = get_next_item()
