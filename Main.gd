extends Node2D

var map_current
var map_other
var check_point
var level = 1
const nb_levels = 1
var MAP_1
var MAP_2

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level(level)
	save_check_point()
func load_level(level):
	MAP_1 = load("res://levels/level_%d/TileMap1.tscn" % level)
	MAP_2 = load("res://levels/level_%d/TileMap2.tscn" % level)
	reload_level(level)

func reload_level(level):
	map_current = MAP_1.instance()
	map_other = MAP_2.instance()
	map_other.pause_mode = PAUSE_MODE_STOP
	map_other.hide()
	call_deferred("add_child", map_current)
	

func swap_map():
	var tmp = map_current
	map_current = map_other
	map_other = tmp
	map_other.pause_mode = PAUSE_MODE_STOP
	map_other.hide()
	map_current.pause_mode = PAUSE_MODE_PROCESS
	map_current.show()
	remove_child(map_other)
	call_deferred("add_child", map_current)
	$Charactere.switch()
	swap_background()
	
func swap_ost():
	if $Charactere.mode == $Charactere.DAY:
		$ost.set_pitch_scale(1.56)
	elif $Charactere.mode == $Charactere.NIGHT:
		$ost.set_pitch_scale(0.8)

func swap_background():
	$ParallaxBackground/Background.switch($Charactere.mode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_swap_map"):
		swap_map()
		swap_ost()
	camera_follow()
	if map_current.ended:
		next_level()
	if map_current.get_parent() == self and map_other.get_parent() == self:
		call_deferred("remove_child", map_other)
	swap_background()
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene("res://Main.tscn")
func camera_follow():
	var size = self.get_viewport_rect().size
	var change = false
	if $Charactere.position.x > size.x - position.x:
		position.x -= size.x
		change = true
	if $Charactere.position.x < -position.x:
		position.x += size.x
		change = true
	if $Charactere.position.y > size.y - position.y:
		position.y -= size.y
		change = true
	if $Charactere.position.y < -position.y:
		position.y += size.y
		change = true
	if change :
		save_check_point()
		$ParallaxBackground/Background.gennerate()

func save_check_point():
	check_point = [$Charactere.position, $Charactere.mode]

func load_check_point():
	remove_child(map_current)
	reload_level(level)
	$Charactere.position = check_point[0]
	$Charactere.position.y -= 10
	if check_point[1] == $Charactere.NIGHT:
		swap_map()
	$Charactere.mode = check_point[1]
	swap_ost()
	
func next_level():
	level += 1
	remove_child(map_current)
	if level > nb_levels:
		get_parent().get_node("HUD").end()
		return
	load_level(level)
	$Charactere.position = Vector2(150, 50);
	$Charactere.mode = $Charactere.DAY
	save_check_point()
	
func death():
	$death.play()
	get_parent().get_node("HUD").death()
	load_check_point()
	
func _on_ost_finished():
	$ost.play()
