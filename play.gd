extends Node2D
var scene = load("res://Bomb.tscn")
var bomb = scene.instance()

func _on_Timer_timeout():
	bomb.position = $SpawnPos.position
	add_child(bomb)
	bomb = scene.instance()

var points = 0
func increase_score():
	points += 1
	$RichTextLabel.text = str(points)
