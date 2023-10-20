extends Node2D

onready var screensize = get_viewport_rect().size
export var MarginBoundary = 150
export var Min_Distance = 70
var clickcounter = 1

func _process(_delta):
	$Point1.look_at($Point2.position)
	$Point2.look_at($Point1.position)

func _unhandled_input(event):
	var clickpos = Vector2()
	if	$Point1/Sprite.frame != 13 and $Point1/AnimationPlayer.is_playing() == false:
		if Input.is_action_pressed("lclick"):
			clickpos = Vector2(clamp(event.position.x, MarginBoundary, screensize.x - MarginBoundary ), clamp(event.position.y, 0, screensize.y))
		if clickcounter == 1 and Input.is_action_pressed("lclick"):
			$Laser.laser_off()
			$Point1/Sprite.frame = 0
			$Point2/Sprite.frame = 0
			$Point2.visible = false
			$Point2/PointBody/CollisionShape2D.disabled = true
			$Point1.position = clickpos
			clickcounter += 1
		if Input.is_action_pressed("lclick") and clickpos.distance_to($Point1.position) > Min_Distance:
			$Point2.visible = true
			$Point2.position = clickpos
			$Point2/PointBody/CollisionShape2D.disabled = false
		if Input.is_action_just_released("lclick") and $Point2.visible == true:
			shoot()
			clickcounter = 1
	
func shoot():
	$Point1/AnimationPlayer.play("Shoot")
	$Point2/AnimationPlayer.play("Shoot")
func death():
	$Laser.laser_off()
	$Point1/AnimationPlayer.play("Death")
	$Point2/AnimationPlayer.play("Death")
	get_parent().get_node("Ball").queue_free()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Shoot":
		$Laser.laser_on()
	if anim_name == "Death":
		emit_signal("playerdeath")
		queue_free()
