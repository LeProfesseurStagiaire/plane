extends Node2D

onready var enemi = preload("res://scene/enemi_type_1.tscn")
onready var tree = preload("res://scene/enemi_type_2.tscn")

onready var difficulty = {
1:{"e_type":[tree],"plane_speed":5,"spawn_speed":Vector2(1,2)},
2:{"e_type":[enemi],"plane_speed":5,"spawn_speed":Vector2(1,2)},
3:{"e_type":[enemi,tree],"plane_speed":6,"spawn_speed":Vector2(0.7,1.5)},
4:{"e_type":[enemi,tree],"plane_speed":5,"spawn_speed":Vector2(1,1.5)},
5:{"e_type":[enemi],"plane_speed":4,"spawn_speed":Vector2(0.2,0.5)},
6:{"e_type":[tree],"plane_speed":5,"spawn_speed":Vector2(0.6,0.8)},
7:{"e_type":[enemi,tree],"plane_speed":6,"spawn_speed":Vector2(0.5,0.9)},
8:{"e_type":[enemi,tree],"plane_speed":7,"spawn_speed":Vector2(0.4,0.5)}
}

var score = 0
var goal = 80
var stape = 1

var game_runing = false
var p_death = false

func _ready():
	$plane.speed = self.difficulty.get(stape).get("plane_speed")

func p_die():
	p_death = true
	game_runing = false
	$Control/CanvasLayer/p_death.show()

func init():
	score = (goal/8) * (stape - 1)
	game_runing = false
	p_death = false
	$plane.init()
	$Control/CanvasLayer/p_death.hide()

func _process(delta):
	if ! game_runing && ! p_death:
#		if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		if Input.is_action_just_pressed("action"):
			game_runing = true
			$enemi_spawn.start(rand_range(1,2))
	if ! game_runing && p_death:
		if Input.is_action_just_pressed("action"):
			init()

func _on_Timer_timeout():
	randomize()
	if score < goal  && game_runing:
		var e = self.difficulty.get(stape).get("e_type")[randi() % self.difficulty.get(stape).get("e_type").size()].instance()
		self.add_child(e)
		
		$enemi_spawn.start(rand_range(self.difficulty.get(stape).get("spawn_speed").x,self.difficulty.get(stape).get("spawn_speed").y))
		if rand_range(0,10) >7:
			e.global_position = Vector2($plane/plane_body.global_position.x + rand_range(-40,40),$plane.global_position.y - 650)
		else:
			e.global_position = Vector2($plane/plane_body.global_position.x + rand_range(-220,220),$plane.global_position.y - 650)

func _on_distance_timeout():
	if score < goal && score >= (goal/8) * stape:
		stape += 1
		$plane.speed = self.difficulty.get(stape).get("plane_speed")
		$Control/CanvasLayer/stape.text = "stape : "+str(stape)
		$Control.new_stape()
	if game_runing:
		if score < goal:
			score += 1
			$distance.start(1)
		else:
			$distance.stop()
			stape = 1
			get_tree().change_scene("res://scene/end.tscn")