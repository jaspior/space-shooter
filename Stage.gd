extends Node2D

var is_gameover = false

var asteroid = preload("res://Asteroid.tscn")
const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180
var score : int = 0

func _ready():
	randomize()
	$Player.connect("destroyed",self,"_on_player_destroyed")
	
func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	if is_gameover and Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://Stage.tscn")
	
func _on_player_destroyed():
	$UI/Retry.show()
	is_gameover = true


func _on_SpawnTimer_timeout():
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, rand_range(0, SCREEN_HEIGHT))
	asteroid_instance.connect("score", self, "_on_player_score")
	asteroid_instance.move_speed += score
	add_child(asteroid_instance)
	$SpawnTimer.wait_time*=0.99

func _on_player_score():
	score += 1
	$UI/Score.text = "Score: "+str(score)
