extends KinematicBody2D

export (int) var DAMAGE = 10
export (int) var SPEED = 2

var direction = Vector2(0,0)

func init(position, direction):
	self.global_position = position
	self.direction = direction * SPEED

func _process(delta):
	move_and_collide(direction*delta)