extends TextureButton
var current_skill = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var words: Array = current_skill.split("-")
	for i in range(words.size()):
		words[i] = words[i].capitalize()
	var capitalized_skill = " ".join(words)
	$RichTextLabel.text = "[center]" + str(capitalized_skill) + "[/center]"
