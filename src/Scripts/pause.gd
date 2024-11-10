extends Control

signal play

func _on_play_pressed() -> void:
	emit_signal("play")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Scenes/main_menu.tscn")
	GlobalStats.reset()
