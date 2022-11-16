extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button4_button_down():
	var children : Array = get_parent().get_children()
	
	for n in children.size():
		get_parent().get_child(n).hide()
	
	var settings : Array = get_parent().get_parent().get_node("mainmenu").get_children();
	
	for n in settings.size():
		get_parent().get_parent().get_node("mainmenu").get_child(n).show()# Replace with function body.
