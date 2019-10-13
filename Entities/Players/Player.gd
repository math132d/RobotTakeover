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
		
func attack(direction:Vector2):
	if active_weapon.can_fire():
		.attack(direction)
		
		var BulletDisplacment
		
		BulletDisplacment = Vector2(0,-20)+direction.normalized()*30 #moves the bulletposistion so not to hit self
		active_weapon.fire(direction,(get_position()+BulletDisplacment))
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed == true:
			attack(FacingVec)

func _physics_process(delta):
	FacingVec = get_viewport().get_mouse_position()-get_position()
	facing = direction_to_facing(FacingVec.normalized())
	