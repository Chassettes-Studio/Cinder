extends Node2D

var time = 0
var deaths = 0
var fade = 1
var end = false

func _ready():
	$Timer.start()

func _process(delta):
	var timer = get_parent().get_node("Main/Charactere/dashreset")
	$ProgressBar.value = (timer.wait_time - timer.time_left)/timer.wait_time * 100
	if end and Input.is_action_pressed("pause"):
		get_tree().paused = false
		get_tree().change_scene("res://mainmenu.tscn")

func _on_Timer_timeout():
	time += $Timer.wait_time
	$TimeText.clear()
	$TimeText.append_bbcode("%.2f"%time)
	$TimeText.update()

func death():
	deaths += 1
	$DeathText.clear()
	$DeathText.append_bbcode("X %d"%deaths)
	$DeathText.update()

func end():
	$Timer.stop()
	end = true
	get_tree().paused = true
	self.pause_mode = PAUSE_MODE_PROCESS
	$FadingTimer.start()
	

func _on_FadingTimer_timeout():
	fade -= 0.01
	get_parent().get_node("Main").modulate = Color(fade, fade, fade)
	if fade <= 0:
		$FadingTimer.stop()
		$EndText.show()
