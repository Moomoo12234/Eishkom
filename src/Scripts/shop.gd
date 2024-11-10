extends Control

@export var powerGenerators: Array[powerGenerator]
@export var powerPlant: PackedScene
@export var powerGeneratorsContainer: Node2D
@export var buySound: AudioStreamPlayer
@export var poorSound: AudioStreamPlayer

func setupPrices() -> void:
	for i in powerGenerators:
		if i.originalPrice == null:
			i.originalPrice = i.price

func spawnPowerPlant(index: int) -> void:
	if GlobalStats.money >= powerGenerators[index].price:
		var p = powerPlant.instantiate()
		p.powerGeneratorStats = powerGenerators[index]
		p.updateSprite()
		powerGeneratorsContainer.add_child(p)
		GlobalStats.money -= powerGenerators[index].price
		buySound.play()
		powerGenerators[index].price *= 1.2
	else:
		poorSound.play()

func setupShop() -> void:
	for i in range(len(powerGenerators)):
		powerGenerators[i].price = powerGenerators[i].originalPrice

func updateShop() -> void:
	for i in range(len(powerGenerators)):
		var btn = get_children()[i].get_node("TextureButton")
		if powerGenerators[i].price > GlobalStats.money:
			btn.material.set_shader_parameter("tint", true)
		else:
			btn.material.set_shader_parameter("tint", false)
		
		var priceLabel = get_children()[i].get_node("Label")
		priceLabel.text = "$" + str(powerGenerators[i].price)

func _ready() -> void:
	setupPrices()
	setupShop()

func _process(delta: float) -> void:
	updateShop()

func _on_texture_button_coal_pressed() -> void:
	spawnPowerPlant(0)

func _on_texture_button_solar_pressed() -> void:
	spawnPowerPlant(1)

func _on_texture_button_naturalGas_pressed() -> void:
	spawnPowerPlant(2)

func _on_texture_button_wind_pressed() -> void:
	spawnPowerPlant(3)

func _on_texture_button_nuclear_pressed() -> void:
	spawnPowerPlant(4)

func _on_texture_button_forest_pressed() -> void:
	spawnPowerPlant(5)

func _on_texture_button_carbonSucker_pressed() -> void:
	spawnPowerPlant(6)
