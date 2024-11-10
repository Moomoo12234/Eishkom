extends Node

func _ready() -> void:
	$music1.play()

func _on_music_1_finished() -> void:
	$music2.play()

func _on_music_2_finished() -> void:
	$music3.play()
	
func _on_music_3_finished() -> void:
	$music1.play()
