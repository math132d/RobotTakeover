extends Node

export (int) var FIRE_SPEED = 1 #Bullets per second
export (PackedScene) var BULLET

func _ready():
	$cooldown.wait_time = 1.0 / FIRE_SPEED
	
func fire(direction, place):
	if $cooldown.is_stopped():
		$cooldown.start()
		
		var bullet = BULLET.instance()
		get_node(".").add_child(bullet)
		bullet.init(place,direction)
		return true
	else:
		return false

func can_fire():
	return $cooldown.is_stopped();