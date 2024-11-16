extends Control

@export var env: Environment

func toggleBloom():
	if not GlobalStats.bloom:
		$WorldEnvironment.environment = null
	else:
		$WorldEnvironment.environment = env

func _ready() -> void:
	$Title/AnimationPlayer.play("hover")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$Title/AnimationPlayer.play("hover")

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		GlobalStats.difficulty = $Difficulty/HSlider.value
		$scrollBarSelect.pitch_scale = 2 - (0.5 * $Difficulty/HSlider.value)
	$scrollBarSelect.play()

func _on_check_box_toggled(toggled_on: bool) -> void:
	GlobalStats.bloom = toggled_on
	toggleBloom()
