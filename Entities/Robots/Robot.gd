extends "res://Entities/Character.gd"

var Player #Holder for player charater
var agro = 50 #agro int describes robot agressiveness in percent

func _ready():
	Player = get_node("/root/Level/YSort/AgressiveGuy") #finds player character in scene

func _process(delta):
	
	#if there is a player it will follow player
	if Player:
		var movment = Player.get_position() - get_position()
		movment = movment.normalized()
		move(movment)
	else:
		print("no player")

func bullet_hit(bullet):
	.bullet_hit(bullet)
	take_damage(bullet.DAMAGE)

func update_healthbar():
	var Procent_Health = (float(self.DEFAULT_HEALTH)-float(self.health))/100
	$Health/Health.scale = Vector2 (1-Procent_Health,1)