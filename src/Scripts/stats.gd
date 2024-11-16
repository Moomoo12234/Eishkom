extends Control

func updateStats() -> void:
	$powerGeneration/Label.text = str(round(GlobalStats.powerGeneration - GlobalStats.demannd))
	$Money/money.text = "$" + str(GlobalStats.money)
	$Pollution/ProgressBar.value = GlobalStats.pollution
	$Pollution/Label.text = str(GlobalStats.pollution) + "/200"
	$Money/score.text = str(GlobalStats.score)
	if GlobalStats.demannd == 0:
		$powerGeneration/Label2.text = "-1"
	else:
		$powerGeneration/Label2.text = "-" + str(GlobalStats.demannd)

func _process(delta: float) -> void:
	updateStats()
