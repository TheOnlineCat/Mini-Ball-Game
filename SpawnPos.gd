extends Area2D
onready var screen = get_viewport_rect().size
export var margin = Vector2(200, 100)

func _physics_process(delta: float) -> void:
	if len(get_overlapping_bodies()) >= 1:
		var randpos = Vector2(rand_range(margin.x,screen.x-margin.x), rand_range(margin.y,screen.y-margin.y))
		self.position = randpos

