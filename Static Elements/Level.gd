extends Node

func _process(delta):
	
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
		$YSort/AgressiveGuy.move(movement)
	