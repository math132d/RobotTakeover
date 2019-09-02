extends Node

export (int) var FIRE_SPEED = 1 #Bullets per second
export (PackedScene) var BULLET

func _ready():
	$cooldown.wait_time = 1 / FIRE_SPEED
	
func fire(direction, posistion):
	if $cooldown.is_stopped():
		$cooldown.start()
		
		var bullet = BULLET.instance()
		get_node(".").add_child(bullet)
		bullet.init(posistion,direction)
		return true
	else:
		return false
func _input(event):
	if event is InputEventMouseButton:
		fire(get_viewport().get_mouse_position(),Vector2(0,0))