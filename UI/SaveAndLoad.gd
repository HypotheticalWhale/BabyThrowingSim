extends Control

func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)

	var node_data = GlobalVars.call("save")
	var json_string = JSON.stringify(node_data)
	save_game.store_line(json_string)
		
		
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		printerr("user://savegame.save not found.")
		return

	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			printerr("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		if node_data["id"] == "GlobalVars":
			GlobalVars.highscore = node_data["highscore"]
