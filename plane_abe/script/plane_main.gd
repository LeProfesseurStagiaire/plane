extends Node2D

var death = false
var speed = 5

func init():
	self.position = Vector2(0,0)
	self.modulate = Color(1,1,1,1)
	death = false
	$plane_body.dir = null
	$plane_body.position = Vector2(0,0)

func _process(delta):
	if !death:
		self.position.y -= speed

func game_ended():
	print("oui")

func _on_area_area_entered(area):
	if area.is_in_group("enemi"):
		self.modulate = Color(1,1,1,0)
		death = true
		get_tree().get_current_scene().p_die()