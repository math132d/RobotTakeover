extends KinematicBody2D

export (int) var DAMAGE = 10
export (int) var SPEED = 20

var direction = Vector2(0,0)

func init(place, direction):
	direction = direction.normalized()
	position = place
	self.rotation = direction.angle() + PI/2
	self.direction = direction * SPEED

func _process(delta):
	var collision = move_and_collide(direction*delta)
	
	if collision:
		do_collision()


func do_collision():
	queue_free()
	pass