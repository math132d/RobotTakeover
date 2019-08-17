extends KinematicBody2D

enum {UP, DOWN, LEFT, RIGHT}

#Export all "default values" not to be modified during runtime
export (int) var DEFAULT_SPEED = 20
export (int) var DEFAULT_HEALTH = 100
export (float) var DEFAULT_FRICTION = 2
export (PackedScene) var active_weapon

#Apply default values to modyfiable vars
onready var health = DEFAULT_HEALTH
onready var speed = DEFAULT_SPEED

var facing = DOWN

var accl_vec = Vector2(0,0)
var move_vec = Vector2(0,0)

func _process(delta):
	
	move_vec += accl_vec
	accl_vec *= 0
	
	move_and_slide(move_vec)
	
	move_vec -= move_vec.normalized()*DEFAULT_FRICTION
	
	if move_vec.length() < 2:
		move_vec = Vector2(0,0)
	
func _on_bullet_hit(body):
	
	body.hit(self)
	print("ouch")
	
	pass
	
func vec_to_direction(vector:Vector2):
	#Function to determine caresian direction from a vector.
	#Returns Direction Enum
	
	var direction = DOWN
	
	if abs(vector.x) > abs(vector.y):
		direction = LEFT if vector.x < 0 else RIGHT
	else:
		direction = UP if vector.y < 0 else DOWN
		
	return direction

func move(direction):
	
	direction = direction.normalized()
	accl_vec = direction*speed
	
	self.facing = vec_to_direction(direction)
	
	#Play the appropriate animation
	match self.facing:
		UP:
			$Character/AnimationPlayer.play("WalkUp")
		DOWN:
			$Character/AnimationPlayer.play("WalkDown")
		LEFT:
			$Character/AnimationPlayer.play("WalkLeft")
		RIGHT:
			$Character/AnimationPlayer.play("WalkRight")
	
	pass
	
#func fire(direction):
#	active_weapon.fire(direction)

#DEBUG CRAP
func _input(event):
	if event is InputEventMouseButton:
		self.move_vec *= 0
		move((event.position-self.position).normalized())
