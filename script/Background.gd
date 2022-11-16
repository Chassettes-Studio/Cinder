extends TileMap

# Called when the node enters the scene tree for the first time.
var Tile_set = preload("res://levels/tildmapbackground.tres")
var rng = RandomNumberGenerator.new()

func _ready():
	self.tile_set = Tile_set
	self.modulate = Color(0.5,1,1)
	gennerate()

func switch(mode):
	if mode == 0: #day
		self.modulate = Color(0.5,1,1)
	else :
		self.modulate = Color(0.8,0.2,0.5)

func gennerate():
	clear()
	var sol = rng.randi_range(19-5, 19 + 5)
	var platforme = 0
	
	for x in range(64):
		var n_sol = new_sol(sol)
		if platforme != 0:
			platforme -= 1
		for y in range(38):
			if get_cell(x, y) != -1:
				pass
			elif y < sol:
				if platforme == 0 and y < sol - 5 and rng.randi_range(0, 20) == 0:
					set_cell(x, y, 13)
					set_cell(x+1, y, 14)
					set_cell(x+2, y, 15)
					platforme = 3
			elif y == sol:
				if get_cell(x-1, y) == -1:
					 set_cell(x, y, 25)
				elif sol < n_sol:
					set_cell(x, y, 27)
				else:
					set_cell(x, y, 2)
			else :
				set_cell(x, y, 5)
				if y > sol + 5 and rng.randi_range(0, max(0,30-y)) == 0:
					set_cell(x, y, 8)
					set_cell(x+1, y, 8)
					set_cell(x+2, y, 8)
		sol = n_sol
	for x in range(64):
		for y in range(38):
			if get_cell(x,y) == -1 and get_cell(x, y+1) in [2, 14]:
				if rng.randi_range(0, 5) == 0:
					set_cell(x, y, rng.randi_range(20, 24))

func new_sol(sol):
	var rand = int(max(rng.randi_range(0, 8) - 5, 0))
	rand *= (1 if bool(rng.randi_range(0, 1))else -1 )
	return sol - rand

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
