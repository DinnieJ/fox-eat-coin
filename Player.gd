extends Area2D


export (int) var speed
# Declare member variables here. Examples:
var screensize = Vector2(480, 720)
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello world")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
	print("FPS: %s" % round(1/delta))
	position += velocity * delta
	position.x = clamp(position.x, 0, 480)
	position.y = clamp(position.y, 0 , 720)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	var p_speed = speed
	if Input.is_key_pressed(KEY_SHIFT):
		p_speed *= 2
	if velocity.length() > 0:
		velocity = velocity.normalized() * p_speed
	
	
