extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	$ParallaxBackground/ParallaxLayer/Sprite2D.centered = false
	OS.is_debug_build()
	
	pass



