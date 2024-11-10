extends Node2D

func unPause() -> void:
	$Pause.position.x = 1252
	GlobalStats.paused = false
	$DemandTimer.start()
	$StatsTimer.start()

func pause() -> void:
	$Pause.position.x = 0
	GlobalStats.paused = true
	$DemandTimer.stop()
	$StatsTimer.stop()

func setDifficulty():
	$DemandTimer.start(5 * (4 - GlobalStats.difficulty))
	$Stats/powerGeneration/ProgressBar.max_value = $DemandTimer.wait_time

func die():
	$Dead.updateStats()
	$Dead.position.x = 0
	GlobalStats.paused = true
	$DeadSound.play()

func updateStats():
	if not GlobalStats.paused:
		if  GlobalStats.pollution > -1:
			GlobalStats.pollution += GlobalStats.pollutionPerSecond
		if not GlobalStats.pollution > 0:
			GlobalStats.pollution = 0
		GlobalStats.score += 1
		if GlobalStats.score % 50 == 0 and GlobalStats.maxBroken < 5:
			GlobalStats.maxBroken += 1
		GlobalStats.money += GlobalStats.moneyPerSecond
		$Stats/powerGeneration/ProgressBar.value = $DemandTimer.wait_time - $DemandTimer.time_left
	if $DemandTimer.time_left >= $DemandTimer.wait_time * 0.4:
		GlobalStats.canBreak = true
	else:
		GlobalStats.canBreak = false

func _ready() -> void:
	setDifficulty()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		pause()

func _on_timer_timeout() -> void:
	if not GlobalStats.paused:
		updateStats()
		if round(GlobalStats.powerGeneration - GlobalStats.demannd) < 1:
			$Alarm.play()
		if GlobalStats.pollution >= GlobalStats.maxPollution:
			die()

func _on_demand_timer_timeout() -> void:
	if not GlobalStats.paused:
		if round(GlobalStats.powerGeneration - GlobalStats.demannd) < 1:
			die()
		if GlobalStats.demannd == 0:
			GlobalStats.demannd = 1
		else:
			GlobalStats.demannd += 1
		GlobalStats.broken = 0

func _on_pause_play() -> void:
	unPause()
