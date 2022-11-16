extends KinematicBody2D

onready var player = get_parent().get_parent().get_parent().get_node("Charactere")
var speed = 300
var targeted = 0
var motion = Vector2()
var player_in_area = false


func _physics_process(_delta):
	if player_in_area:
		motion = player.position - position*2
		motion=motion.normalized()*speed
		motion = move_and_slide(motion)
	#print(player.position, position)




func _on_Area2D_body_entered(body):
	if body == player:
		player_in_area = true
		

func _on_Area2D_body_exited(body):
	if body==player:
		player_in_area = false
