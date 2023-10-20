extends Node2D
onready var point_1 = get_parent().get_node("Point1")
onready var point_2 = get_parent().get_node("Point2")

func _physics_process(_delta):
	position = (point_1.position + point_2.position) / 2
	look_at(point_1.position)
	scale.x = (point_2.position.distance_to(point_1.position)-80)/2
func laser_on():
	self.visible = true
	$Paddle/CollisionShape2D.set_deferred("disabled", false)
func laser_off():
	self.visible = false
	$Paddle/CollisionShape2D.set_deferred("disabled", true)
