extends Node2D

export (int) var lifetime :int = 10 #seconds
export (Texture) var sprite
export (PackedScene) var effect

var ground_level :int
var grounded :bool = false

var velocity :Vector2
var gravity :Vector2 = Vector2(0, 10)
var power :int = 120

func _ready():
	if sprite != null:
		$Sprite.texture = sprite
	$lifetime.wait_time = lifetime

func init(position: Vector2, ground_level: int):
	self.position = position
	self.ground_level = ground_level
	
	$lifetime.start()
	visible = true
	
	velocity = Vector2(rand_range(-1, 1), -randf()) * power
	
func _physics_process(delta):
	if !grounded:
		position += velocity * delta
		velocity += gravity
		
		if position.y >= ground_level: grounded = true

func _on_lifetime_over():
	queue_free()