extends Node

func reset():
	difficulty = 2
	
	pollution = 0
	pollutionPerSecond = 0
	maxPollution = 200

	powerGeneration = 0
	demannd = 0

	money = 50
	moneyPerSecond = 0
	score = 0
	paused = false
	
	broken = 0
	maxBroken = 1
	canBreak = true

var difficulty = 2

var pollution = 0
var pollutionPerSecond = 0
var maxPollution = 200

var powerGeneration = 0
var demannd = 0

var money = 100
var moneyPerSecond = 0
var score = 0
var paused = false

var broken: int = 0
var maxBroken: int = 0
var canBreak: bool = true

var bloom: bool = true
