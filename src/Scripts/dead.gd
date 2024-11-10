extends Control

func updateStats() -> void:
	$Title/Score.text = str(GlobalStats.score)

func _on_play_pressed() -> void:
	GlobalStats.reset()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	GlobalStats.reset()
	get_tree().change_scene_to_file("res://src/Scenes/main_menu.tscn")
