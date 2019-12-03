extends Node2D

onready var enemi = preload("res://scene/enemi_plane_1.tscn")
onready var tree = preload("res://scene/tree.tscn")
onready var fire = preload("res://scene/fire.tscn").instance()
var choose = ["enemi","tree"]
var score = 0
var goal = 10
var camera_follow = true
var game_runing = false
var p_death = false

func p_die():
	p_death = true
	game_runing = false
	$Control/CanvasLayer/p_death.show()

func init():
	score = 0
	camera_follow = true
	game_runing = false
	p_death = false
	$plane.init()
	$Control/CanvasLayer/p_death.hide()

func _process(delta):
	if camera_follow :
		$Camera2D.global_position.y = $plane.global_position.y - 150
	if ! game_runing && ! p_death:
		if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
			game_runing = true
			$enemi_spawn.start(rand_range(1,2))
	if ! game_runing && p_death:
		if Input.is_action_just_pressed("left"):
			init()
		if Input.is_action_just_pressed("right"):
			init()

func _on_Timer_timeout():
	randomize()
	if score < goal  && game_runing:
		var e = self.get(choose[rand_range(0,choose.size())]).instance()
		self.add_child(e)
		e.global_position = Vector2(rand_range(-230,230),$plane.global_position.y - 650)
		$enemi_spawn.start(rand_range(0.5,1))

func _on_distance_timeout():
	if game_runing:
		if score < goal:
			score += 1
			$distance.start(1)
		else:
			$distance.stop()
			$camera_stop.start(1.5)
			fire.global_position = Vector2($plane.position.x,$plane.position.y - 600)
			self.add_child(fire)
			move_child(fire,2)

func _on_camera_stop_timeout():
	if game_runing:
		camera_follow = false
		$plane.game_ended()
		for p in fire.get_children():
			p.emitting = false