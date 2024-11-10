extends StaticBody2D

@export var powerGeneratorStats: powerGenerator
@export var gridSize: int = 32

var placed = false
var hovered = false
var broken = false
var canBreak = true

func failPlace() -> void:
	$Break.play()
	$GPUParticles2D.emitting = true
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 10, 0.1)
	tween.tween_property(self, "rotation_degrees", 0, 0.1)

func fix() -> void:
	GlobalStats.broken += 1
	broken = false
	canBreak = false
	$breakDelay.start()
	$cross.visible = false
	GlobalStats.powerGeneration += powerGeneratorStats.power
	GlobalStats.pollutionPerSecond += powerGeneratorStats.pollutionPerSecond
	print(powerGeneratorStats.pollutionPerSecond)
	GlobalStats.money -= powerGeneratorStats.price / 2
	GlobalStats.moneyPerSecond += powerGeneratorStats.power
	$Fix.play()

func breakPlant() -> void:
	broken = true
	$cross.visible = true
	GlobalStats.powerGeneration -= powerGeneratorStats.power
	GlobalStats.pollutionPerSecond -= powerGeneratorStats.pollutionPerSecond
	GlobalStats.moneyPerSecond -= powerGeneratorStats.power
	GlobalStats.broken += 1
	$Break.play()

func sell() -> void:
	if broken:
		GlobalStats.money += powerGeneratorStats.price / 2
	else:
		GlobalStats.money += powerGeneratorStats.price
	GlobalStats.powerGeneration -= powerGeneratorStats.power
	GlobalStats.pollutionPerSecond -= powerGeneratorStats.pollutionPerSecond
	queue_free()
	
func actions() -> void:
	if not placed:
		move()
	if Input.is_action_just_pressed("Place") and not placed and not len($Area2D.get_overlapping_areas()) > 0:
		place()
	if Input.is_action_just_pressed("Place") and not placed and len($Area2D.get_overlapping_areas()) > 0:
		failPlace()
	if Input.is_action_just_pressed("Sell") and hovered and placed:
		sell()
	if Input.is_action_just_pressed("Fix"):
		if hovered and placed and broken and GlobalStats.money > powerGeneratorStats.price / 2:
			fix()

func updateSprite() -> void:
	$Sprite2D.texture = powerGeneratorStats.sprite

func lockGrid(num: int) -> int:
	return (round(num / gridSize) * gridSize) + gridSize / 2

func place() -> void:
	placed = true
	$Timer.start()
	GlobalStats.powerGeneration += powerGeneratorStats.power
	GlobalStats.pollutionPerSecond += powerGeneratorStats.pollutionPerSecond
	GlobalStats.moneyPerSecond += powerGeneratorStats.power
	$GPUParticles2D.emitting = true
	$Place.play()
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1.6, 1.6), 0.1)
	tween.tween_property($Sprite2D, "scale", Vector2(2, 2), 0.1)

func move() -> void:
	position = Vector2(lockGrid(get_global_mouse_position().x), lockGrid(get_global_mouse_position().y))

func _onready() -> void:
	updateSprite()
	
func _process(delta: float) -> void:
	actions()

func _on_timer_timeout() -> void:
	if not GlobalStats.paused:
		if randi_range(1, 1000) <= powerGeneratorStats.breakChance * 1000 and not broken and GlobalStats.broken < GlobalStats.maxBroken and GlobalStats.canBreak and canBreak:
			breakPlant()

func _on_break_delay_timeout() -> void:
	canBreak = true

func _on_area_2d_mouse_entered() -> void:
	hovered = true
	
func _on_area_2d_mouse_exited() -> void:
	hovered = false
