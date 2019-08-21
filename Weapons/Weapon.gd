extends Node

export (int) var FIRE_SPEED = 1 #Bullets per second
export (PackedScene) var BULLET

func _ready():
	$cooldown.wait_time = 1 / FIRE_SPEED
	
func fire(direction):
	if $cooldown.is_stopped():
		$cooldown.start()
		
		var bullet = BULLET.instance()
		
		get_tree().get_root().add_child(bullet)
		return true
	else:
		return false
