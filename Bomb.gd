extends KinematicBody2D
var tracking = bool(false)
var in_proximity = bool(false)
var speed = 250
var dir = Vector2(0,0)

signal player_death

func _ready():
	$AnimationPlayer.play("idle")

func _physics_process(delta):
	if tracking == true:
		dir = (get_parent().get_parent().get_node("Paddle/Point1").global_position - self.global_position).normalized()
		move_and_collide(dir * delta * speed)

func explode():
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("explode")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "explode":
		get_parent().queue_free()


func _on_Radar_body_entered(body) -> void:
	if body.name == "PointBody":
		explode()
		yield(get_tree().create_timer(0.2), "timeout")
		get_parent().get_parent().get_node("Paddle").death()
		

func _on_Radar_body_exited(body: Node) -> void:
	if body.name == "PointBody":
		in_proximity = false

func _on_Timer_timeout() -> void:
	tracking = true

func playerdeath():
	get_parent().queue_free()
