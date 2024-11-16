extends Control

func updateStats() -> void:
	$Title/Score.text = "Your Score Was: " + str(GlobalStats.score)
	$Title/Highscore.text = "Highscore: " + str(SaveManager.loadData())

func _on_play_pressed() -> void:
	GlobalStats.reset()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	GlobalStats.reset()
	get_tree().change_scene_to_file("res://src/Scenes/main_menu.tscn")
