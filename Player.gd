extends Area2D

const MOVE_SPEED = 150

const SCREEN_WIDTH = 320
const SCREEN_HEIGHT = 180

var can_shoot = true

var shot_scene = preload("res://Shot.tscn")
var explosion = preload("res://Explosion.tscn")

signal destroyed

func _process(delta):
	var input_dir = Vector2()
	if Input.is_key_pressed(KEY_UP):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		input_dir.y += 1.0
	if Input.is_key_pressed(KEY_LEFT):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_RIGHT):
		input_dir.x += 1.0
	position += (delta * MOVE_SPEED) * input_dir
	
	if position.x < 8.0:
		position.x = 8.0
	elif position.x > SCREEN_WIDTH - 8:
		position.x = SCREEN_WIDTH - 8
	if position.y <  8.0:
		position.y = 8.0
	elif position.y > SCREEN_HEIGHT - 8:
		position.y = SCREEN_HEIGHT -8
		
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var stage_node = get_tree().get_root().get_node("Stage")
		var shot_instance1 = shot_scene.instance()
		var shot_instance2 = shot_scene.instance()
		shot_instance1.position = position + Vector2(9,-5)
		shot_instance2.position = position + Vector2(9,+5)
		stage_node.add_child(shot_instance1)
		stage_node.add_child(shot_instance2)
		can_shoot = false
		$Reload.start()


func _on_Reload_timeout():
	can_shoot = true


func _on_Player_area_entered(area):
	if area.is_in_group("asteroid"):
		queue_free()
		emit_signal("destroyed")
		
		var stage = get_tree().get_root().get_node("Stage")
		var explosion_instance = explosion.instance()
		explosion_instance.position = position
		stage.add_child(explosion_instance)
