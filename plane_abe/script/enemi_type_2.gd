extends Node2D

func _ready():
	var t = load("res://scene/tree_presset_"+str(int(randi() % 8 + 1))+".tscn").instance()
	self.add_child(t)

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
