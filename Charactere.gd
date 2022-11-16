extends KinematicBody2D

const up  = Vector2(0,-1)
const gravity = 40
const max_fallspeed = 800
const jump_force= 800
const max_speed = 250
const acceleration = 50
const dash_speed = 1000

var recupdash = 0
var dash = Vector2.ZERO
var nb_jump = 1
var nb_dash = 1
var motion = Vector2()
var dir="Neutral"

const DAY = 0
const NIGHT = 1
var mode = DAY

func _physics_process(_delta):
	
	#chute
	if $dash.time_left == 0:
		motion.y += gravity
		if motion.y > max_fallspeed:
			motion.y=max_fallspeed
	
	
	#deplacement
	motion.x = clamp(motion.x,-max_speed,max_speed)
	
	if Input.is_action_pressed("ui_right"):
		dir="Right"
		if Input.is_action_pressed("ui_left"):
			dir="Neutral"
			motion.x = lerp(motion.x,0,0.3)
			$perso.play("NeutralIdle")
		else:
			motion.x += acceleration
			$perso.play("RightMove")
			
	elif Input.is_action_pressed("ui_left"):
		dir = "Left"
		if Input.is_action_pressed("ui_right"):
			motion.x = lerp(motion.x,0,0.3)
			$perso.play("NeutralIdle")
		else:
			motion.x -= acceleration
			$perso.play("LeftMove")
	else:
		dir="Neutral"
		motion.x = lerp(motion.x,0,0.3)
		#$perso.play("NeutralIdle")
	
	#saut
	if is_on_floor():
		nb_jump=1
		if abs(motion.x) > 1:
			$pas.play()
		else :
			$pas.stop()
			
		if recupdash==1:
			nb_dash=1
			recupdash=0
		
		if Input.is_action_just_pressed("jump"):
			motion.y= -jump_force
			motion.x *= 0.75
			$jump.play()
	#dbjump
	if mode == DAY and not is_on_floor() and nb_jump!=0:
		if Input.is_action_just_pressed("jump"):
			motion.y=-jump_force
			motion.x *= 0.5
			nb_jump-=1
			$jump.play()
	#dash
	if mode == NIGHT and $dashreset.time_left == 0 and Input.is_action_just_pressed("special_move"):
		$dash.start()
		$dashreset.start()
		$dashsd.play()
		position.y -= 1

	if mode == NIGHT and $dash.time_left != 0:
		if Input.is_action_pressed("ui_left"):
			dash.x=-dash_speed
			if $perso.get_animation() != "LeftDash":
				$perso.play("LeftDash")
		elif Input.is_action_pressed("ui_right"):
			dash.x=dash_speed
			if $perso.get_animation() != "RightDash":
				$perso.play("RightDash")
		motion = Vector2.ZERO
		move_and_slide(dash,up)
	else :
		motion = move_and_slide(motion,up)
	
	if motion.y <0 and not $perso.get_animation().ends_with("Jump"):
		$perso.play(dir + "Jump")
		
	if motion.y >0 and not $perso.get_animation().ends_with("Fall"):
		$perso.play(dir + "Fall")
		
	if motion.length() < 1:
		$perso.play("NeutralIdle")

func _on_dash_timeout():
	dash = Vector2.ZERO
	nb_dash-=1

func _on_dashreset_timeout():
	recupdash = 1

func switch():
	if mode == DAY:
		mode = NIGHT
	else:
		mode = DAY


func _on_degats_body_entered(body):
	#print("Hono I ded")
	get_parent().death()


func _on_degats_body_shape_entered(body_id, body, body_shape, area_shape):
	pass

func _on_degats_area_shape_entered(area_id, area, area_shape, self_shape):
	pass

func _on_degats_area_entered(area):
	#print(area.name)
	get_parent().death()
