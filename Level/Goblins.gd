extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		i.add_to_group('goblins')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
