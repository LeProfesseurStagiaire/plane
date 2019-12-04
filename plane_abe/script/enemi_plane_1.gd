extends Node2D

onready var player = get_tree().get_current_scene().get_node("plane/plane_body")
var motion = Vector2(0,0)
var speed = rand_range(0.8,2.2)
onready var type = int(randi() % 2 + 1)

func _ready():
	rotation_degrees = 90
	var s = rand_range(0.9,1.1)
	self.scale = Vector2(s*type,s*type)
	if type == 2:
		self.modulate = Color(1,0.4,0.4)
		s = rand_range(1.3,1.6)
		self.scale = Vector2(s,s)

func _process(delta):
	if rotation_degrees > 60 && rotation_degrees < 120 && type == 1: 
		self.rotate(get_angle_to(player.global_position)*delta * 10 )
	var movedir = Vector2(rand_range(1,4),0).rotated(rotation)
	motion = motion.linear_interpolate(movedir,1)
	position += motion * speed

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
