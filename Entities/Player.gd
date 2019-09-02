extends "res://Entities/Character.gd"

export (PackedScene) var active_weapon
var WEAPON

func _ready():
	if active_weapon.can_instance():
		WEAPON = active_weapon.instance()
		get_node(".").add_child(WEAPON)

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

func _input(event):
	if event is InputEventMouseButton:
		WEAPON.fire(get_viewport().get_mouse_position(),get_position())

func _physics_process(delta):
	var fvek = get_viewport().get_mouse_position()-get_position()
	facing = direction_to_facing(fvek.normalized())
	print(direction_to_facing(fvek.normalized()))
	print(fvek.normalized())
	