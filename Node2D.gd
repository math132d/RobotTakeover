extends Node2D

export (PackedScene) var BULLET

func _input(event):
	if event is InputEventMouseButton:
		var bullet = BULLET.instance()
		bullet.init(event.position, Vector2(1,0).normalized())
		
		add_child(bullet)