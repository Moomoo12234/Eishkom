extends Node2D

@export var parent: Node

@export var scaleFactor: float = 2

func mouse_entered() -> void:
	parent.scale = Vector2(scaleFactor, scaleFactor)
	parent.rotation -= deg_to_rad(2 * scaleFactor)
	$AudioStreamPlayer.pitch_scale = randf_range(0.9, 1)
	$AudioStreamPlayer.play()

func mouse_exited() -> void:
	parent.scale = Vector2(1, 1)
	parent.rotation += deg_to_rad(2 * scaleFactor)

func _ready() -> void:
	get_parent().connect("mouse_entered", self.mouse_entered)
	get_parent().connect("mouse_exited", self.mouse_exited)
