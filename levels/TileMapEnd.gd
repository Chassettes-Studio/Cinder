extends TileMap

var ended = false

func _on_End_body_entered(body):
	if body.name == "Charactere":
		ended = true
