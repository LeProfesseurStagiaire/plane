extends Node2D

onready var player = get_tree().get_current_scene().get_node("plane/plane_body")
var motion = Vector2(0,0)
var speed = rand_range(60,100)

func _ready():
	rotation_degrees = 90

func _process(delta):
	if rotation_degrees > 60 && rotation_degrees < 120: 
		self.rotate(get_angle_to(player.global_position)*delta * 10 )
	var movedir = Vector2(rand_range(1,4),0).rotated(rotation)
	motion = motion.linear_interpolate(movedir,1)
	position += motion * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
