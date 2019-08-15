extends KinematicBody2D

export (int) var DEFAULT_SPEED = 2
export (PackedScene) var active_weapon

var health = 100
var speed = DEFAULT_SPEED
var direction = Vector2(0,0)

var accl_vec = Vector2(0,0)
var move_vec = Vector2(0,0)

func move(direction):
	pass
	
func fire(direction):
	active_weapon.fire(direction)

func _process(delta):
	
	move_vec += accl_vec
	accl_vec *= 0
	
	move_and_slide(move_vec)