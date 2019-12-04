extends Node2D

func _ready():
	randomize()
	self.rotation = rand_range(0,360)
	var s = rand_range(0.4,0.7)
	self.scale = Vector2(s,s)
	self.modulate = Color(rand_range(1,0.5),rand_range(1,0.8),rand_range(1,0.5))