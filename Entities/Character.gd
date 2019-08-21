extends KinematicBody2D

enum {UP, DOWN, LEFT, RIGHT}

#Export all "default values" not to be modified during runtime
export (int) 	var DEFAULT_ACCL_SPEED = 60   #Pixels added to movement vec per second
export (float) 	var DEFAULT_FRICTION   = 20  #Pixels subtracted from movement vec per second
export (int) 	var DEFAULT_MAX_SPEED  = 60  #Max speed in pixels per second

export (int) var DEFAULT_HEALTH = 100
export (PackedScene) var active_weapon

#Statemachine used to control animation
onready var statemachine = $Character/AnimationTree.get("parameters/playback")

#Apply default values to modifyable vars
onready var health = DEFAULT_HEALTH
onready var max_speed = DEFAULT_MAX_SPEED
onready var accl_speed = DEFAULT_ACCL_SPEED

var facing = DOWN

var move_vec = Vector2(0,0)
var accl_vec = Vector2(0,0)

func _physics_process(delta):
	
	#This code adds acceleration to movement in a linear fashion
	#Ensures that movement vectors magnitude will never be higher then max speed.
	if move_vec.length() < max_speed:
		var delta_to_max = max_speed - move_vec.length()
		move_vec += accl_vec.normalized() * min((accl_speed * delta), delta_to_max)
		
	move_and_slide(move_vec)
	
	#This code subtracts friction from movement in a linear fashion
	#Ensures that friction will never cause "negative" movement in case friction is heigher then delta to min
	if move_vec.length() > 0:
		var delta_to_min = move_vec.length()
		move_vec -= move_vec.normalized() * min((DEFAULT_FRICTION * delta), delta_to_min)
		
	accl_vec *= 0
	
	#Flip the sprite if facing right
	if facing == RIGHT:
		$Character.set_flip_h(true)
	else:
		$Character.set_flip_h(false)
	
	#Travels to the appropriate animation in the statemachine
	if move_vec.length() <= (DEFAULT_FRICTION*delta):
		#Considers the character stationary

		match facing:
			UP:
				statemachine.travel("IdleUp")
			DOWN:
				statemachine.travel("IdleDown")
			LEFT, RIGHT:
				statemachine.travel("IdleSide")
	else:
		#The character is walking. 
		match facing:
			UP:
				statemachine.travel("WalkUp")
			DOWN:
				statemachine.travel("WalkDown")
			LEFT, RIGHT:
				statemachine.travel("WalkSide")

	pass #END OF PHYSICS PROCESS

func _on_BulletDetecetor_entered(body):
	bullet_hit(body)
	
func direction_to_facing(vector:Vector2):
	#Function to determine caresian direction from a vector.
	#Returns Direction Enum
	
	var facing = DOWN
	
	#In case of diagonal movement we would rather have the side view then face-on
	#Therefore the x-axis is weighed higher
	if abs(vector.x * 2) > abs(vector.y):
		facing = LEFT if vector.x < 0 else RIGHT
	else:
		facing = UP if vector.y < 0 else DOWN
		
	return facing

func move(direction):
	
	accl_vec = direction.normalized()
	
	self.facing = direction_to_facing(move_vec.normalized())
	
	pass
	
func bullet_hit(body):
	
	body.do_collision()
	$Character/AnimationPlayer.play("Damaged")
	
	pass
	
func attack(direction):
	
	self.facing = direction_to_facing(direction.normalized())
	
	match facing:
		UP:
			statemachine.start("AttackUp")
		DOWN:
			statemachine.start("AttackDown")
		LEFT, RIGHT:
			statemachine.start("AttackSide")