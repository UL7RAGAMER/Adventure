extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	ProjectSettings.set_setting('debug/shapes/collision/draw_2d_outlines',true)
	pass
