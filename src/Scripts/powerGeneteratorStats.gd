extends Resource
class_name powerGenerator

@export var power: float = 1
@export var pollutionPerSecond: float = 1
@export var price: int = 500
@export_range(0, 1) var breakChance: float
@export var sprite: Texture2D

var originalPrice
