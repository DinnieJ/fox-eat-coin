extends Node2D

export (PackedScene) var Coin
export (int) var playtime
export (int) var num_of_coin

var level
var score
var time_left
var screensize
var playing = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	print(screensize)
	$Player.screensize = screensize
	$Player.hide()
	new_game()

func new_game():
	playing = true
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	spawn_coins()

func spawn_coins():
	for i in range(num_of_coin):
		var c = Coin.instance()
		c.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
		print(c.position)
		$CoinContainer.add_child(c)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
