extends Node2D

func _ready():
	randomize()
	self.rotation = rand_range(0,360)
	var s = rand_range(0.7,1.1)
	$Sprite.scale = Vector2(s,s)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
