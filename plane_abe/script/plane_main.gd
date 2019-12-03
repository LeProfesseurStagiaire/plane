extends Node2D

var death = false

func init():
	self.position = Vector2(0,0)
	self.modulate = Color(1,1,1,1)
	death = false

func _process(delta):
	if !death:
		self.position.y -= 5

func game_ended():
	$plane_body/water.emitting = true

func _on_area_area_entered(area):
	if area.is_in_group("enemi"):
		self.modulate = Color(1,1,1,0)
		death = true
		get_tree().get_current_scene().p_die()