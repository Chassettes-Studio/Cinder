extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


func _on_Button_button_down():
	$clique.play()
	get_tree().change_scene("res://Main.tscn")
	


func _on_Button2_button_down():
	$clique.play()
	var children : Array = get_parent().get_children();
	
	for n in children.size():
		get_parent().get_child(n).hide()
	
	var settings : Array = get_parent().get_parent().get_node("settings").get_children();
	
	for n in settings.size():
		get_parent().get_parent().get_node("settings").get_child(n).show()


func _on_Button3_button_down():
	$clique.play()
	get_tree().quit()


func _on_toggle_fullscreen_button_down():
	OS.window_fullscreen = !OS.window_fullscreen





func _on_mastervolume_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_Button4_button_down():
	var children : Array = get_parent().get_parent().get_node("settings").get_children()
	
	for n in children.size():
		get_parent().get_parent().get_node("settings").get_child(n).hide()
	
	var settings : Array = get_parent().get_children();
	
	for n in settings.size():
		get_parent().get_child(n).show()# Replace with function body.


func _on_mastervolume_value_changed(value):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

