extends Area2D

signal pickup
signal hurt


export (int) var speed
# Declare member variables here. Examples:
var screensize = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
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
	#print("FPS: %s" % round(1/delta))
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0 , screensize.y)

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

func start(start_pos: Vector2):
	set_process(true)
	position.x = start_pos.x
	position.y = start_pos.y
	$AnimatedSprite.animation = "idle"
	return

func die():
	set_process(false)
	print("GAME OVER")
	
	


func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
	pass # Replace with function body.
