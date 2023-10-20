extends KinematicBody2D

export var vel = Vector2(0,1)
export var base = 1.2
var speed = 200
export var aura = 50
onready var point1 = get_parent().get_node("Paddle/Point1")
onready var point2 = get_parent().get_node("Paddle/Point2")
onready var screensize = get_viewport_rect().size

func _physics_process(delta):
	var width = point1.position.distance_to(point2.position)
	var collision_identifier = ""
	vel = vel.normalized()
	move_and_slide(vel * delta * speed * base)
	if self.position.y < -70:
		self.position.y += screensize.y + 140
	elif self.position.y > screensize.y + 70:
		self.position.y -= screensize.y + 140
	if $Aura.scale < Vector2(aura, aura):
		$Aura.scale += Vector2(2,2)
	elif $Aura.scale > Vector2(aura, aura):
		$Aura.scale -= Vector2(2,2)
	if get_slide_count() > 0:
		collision_identifier = get_slide_collision(0).get_collider()
		if collision_identifier.name == "BombBody":
			collision_identifier.explode()
			get_parent().increase_score()
		if collision_identifier.name == "PointBody":
			collision_identifier.get_parent().get_parent().death()
		if collision_identifier.name != "":
			vel = -vel.reflect(get_slide_collision(0).get_normal())
			if collision_identifier.name == "Paddle":
				speed = clamp((100/sqrt(width))*50,200, 500)
				aura += pow(100/sqrt(width), 1.5)
				aura = clamp(aura, 30, 70)
			else:
				aura = 20
				
func end():
	queue_free()
#		print(self.position.distance_to(get_parent().get_node("Paddle/Laser").position))
#		print(to_local(self.position)  to_local(get_parent().get_node("Paddle/Laser").position))



