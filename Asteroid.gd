extends Area2D

var explosion = preload("res://Explosion.tscn")

var move_speed = 50
var score_emitted = false

signal score

func _process(delta):
	position -= Vector2(move_speed*delta, 0)
	if position.x <= -100:
		queue_free()

func _on_Asteroid_area_entered(area):
	pass
	if area.is_in_group("player") or area.is_in_group("shot"):
		if not score_emitted:
			score_emitted = true
			emit_signal("score")
			queue_free()
			
			var stage = get_tree().get_root().get_node("Stage")
			var explosion_instance = explosion.instance()
			explosion_instance.position = position
			stage.add_child(explosion_instance)
