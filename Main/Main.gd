extends Node2D

const BASIC_LAVEL = 5

export (PackedScene) var Gem
var Pollito = preload("res://gem/Pollito.tscn")

var level = 0
var screensize = Vector2.ZERO
var time_left = 0
var score = 0
onready var GameOverTimer = Timer.new()


func _ready():
	randomize()
	OS.center_window()
	timer_settings()
	$HUD/LabelGameOver.visible = false
	time_left = 6
	$HUD.update_timer(time_left)
	screensize = get_viewport().get_visible_rect().size
	print (str(screensize.x) + "x" + str(screensize.y))
	spawn_gems()
	set_pollito_timer()
	$GameTimer.start()


func timer_settings():
	GameOverTimer.wait_time = 2
	GameOverTimer.connect("timeout", self, "_onGameOverTimer_timeout")
	add_child(GameOverTimer)
	
	
func _onGameOverTimer_timeout():
	get_tree().change_scene("res://Menu/Menu.tscn")

	
func _process(delta):
	if $GemConteiner.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_gems()

	
func spawn_gems():
	if Gem != null:
		for index in range(BASIC_LAVEL + level):
			var Gema = Gem.instance()
			Gema.position = \
			Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
			$GemConteiner.add_child(Gema)
			$HUD.update_level(level)
	


func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()




func _on_Player1_picked(type):
	match type:
		"gem":
			score += 1
			$HUD.update_score(score)
		"pollito":
			time_left += 5
			$HUD.update_timer(time_left)


func game_over():
	$GameTimer.stop()
	$HUD/LabelGameOver.visible = true
	$Player1.game_over()
	GameOverTimer.start()
	
	
func set_pollito_timer():
	var interval = rand_range(5, 10)
	$PollitoTimer.wait_time = interval
	$PollitoTimer.start()



func _on_PollitoTimer_timeout():
	$PollitoTimer.stop()
	var pollito = Pollito.instance()
	pollito.position = \
	Vector2(rand_range(25, 700), rand_range(25, 430))
	$GemConteiner.add_child(pollito)
	set_pollito_timer()
	pass # Replace with function body.
