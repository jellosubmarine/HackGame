extends Node2D

func _process(delta):
	var player_loc = $Player.position
	if player_loc.x < 0 or player_loc.x > ProjectSettings.get_setting("display/window/size/width"):
		get_tree().reload_current_scene()
	if player_loc.y < 0 or player_loc.y > ProjectSettings.get_setting("display/window/size/height"):
		get_tree().reload_current_scene()
