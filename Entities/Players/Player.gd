extends "res://Entities/Character.gd"

var active_weapon
var FacingVec


func _ready():
	
	if $Weapons.get_child_count() > 0:
		active_weapon = $Weapons.get_child(0)
	else:
		print("No weapons availible")

func _process(delta):
	
	#moves the payer based on user input
	var movement = Vector2(0,0)
	
	if Input.is_action_pressed("ui_up"):
		movement += Vector2(0,-1)
	if Input.is_action_pressed("ui_down"):
		movement += Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		movement += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		movement += Vector2(1,0)
	
	if movement.length() > 0:
		move(movement)

func _physics_process(delta):
	FacingVec = get_viewport().get_mouse_position()-get_global_transform_with_canvas().origin
	facing = direction_to_facing(FacingVec.normalized())

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed == true:
			attack(FacingVec)

func bullet_hit(bullet):
	.bullet_hit(bullet)
	take_damage(bullet.DAMAGE)

func update_healthbar():
	var HealtProcent = 1-(float(self.DEFAULT_HEALTH)-float(self.health))/100
	var Hlen = 147*HealtProcent
	print($HUD/Health.region_rect)
	print(health)
	$HUD/Health.region_rect = Rect2(0.739,0,Hlen,49)
	$HUD/Health.position = Vector2(-(2/Hlen) + 2.37,724.897)

func attack(direction:Vector2):
	if active_weapon.can_fire(): #Only play animations etc. when the weapon can fire.
		.attack(direction)
		
		var BulletDisplacment
		
		BulletDisplacment = Vector2(0,-20)+direction.normalized()*30 #moves the bulletposistion so not to hit self
		active_weapon.fire(direction,(get_position()+BulletDisplacment))