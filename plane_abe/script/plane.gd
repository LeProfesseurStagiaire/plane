extends Node2D

var line_node
var max_left
var max_right
var dir = null
var speed = 350
var rotation_max = 5
var rotation_speed = 1
var game_start

func _process(delta):
	if Input.is_action_just_pressed("left") and dir != "left":
		dir = "left"
	if Input.is_action_just_pressed("right") and dir != "right":
		dir = "right"
	if dir :
		max_left = get_parent().get_node("left")
		max_right = get_parent().get_node("right")
		if dir == "left" :
			if self.position.x > max_left.position.x:
				self.position.x += (speed * delta)*-1
				if self.rotation_degrees > (rotation_max*-1):
					rotation_degrees += (rotation_speed*-1)
			else:
				if self.rotation_degrees < 0:
					rotation_degrees -= (rotation_speed*-1)
		elif dir == "right" :
			if self.position.x < max_right.position.x:
				self.position.x += speed * delta
				if self.rotation_degrees < rotation_max:
					rotation_degrees += rotation_speed
			else:
				if self.rotation_degrees > 0:
					rotation_degrees += (rotation_speed*-1)
