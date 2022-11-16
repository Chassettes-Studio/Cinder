extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause()

func pause():
	if get_tree().paused:
		get_tree().paused = false
		var children : Array = get_children();
		for n in children.size():
			get_child(n).hide()
	else:
		get_tree().paused = true
		var children : Array = get_children();
		self.pause_mode = PAUSE_MODE_PROCESS
		for n in children.size():
			get_child(n).show()


func _on_Pause_button_down():
	pause()

func _on_Quit_button_down():
	get_tree().paused = false
	get_tree().change_scene("res://mainmenu.tscn")
	

func _on_Reset_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")# Replace with function body.
