extends "res://Entities/Character.gd"

var Player

func _ready():
	Player = get_node("/root/Level/YSort/Player")

func _process(delta):
	
	#if there is a player it will follow player
	if Player:
		var movment = Player.get_position() - get_position()
		movment = movment.normalized()
		move(movment)
	else:
		print("no player")
