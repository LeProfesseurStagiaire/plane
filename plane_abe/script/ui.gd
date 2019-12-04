extends Control

var objectif = 10
onready var main = get_tree().get_current_scene()

func _ready():
	$CanvasLayer/TextureProgress.max_value = main.goal

func new_stape():
	$CanvasLayer/AnimationPlayer.play("new_stape")

func _process(delta):
	$CanvasLayer/TextureProgress.value = main.score