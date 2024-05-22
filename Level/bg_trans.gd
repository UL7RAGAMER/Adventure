extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	$"../Level 1/CanvasModulate".color = Color(0.302,0.302,0.302,1)

	pass # Replace with function body.


func _on_area_2d_2_body_entered(body):
	$"../Level 1/CanvasModulate".color = Color(0.259,0.38,0.165,1)
	pass # Replace with function body.


func _on_grass_2_body_entered(body):
	$"../Level 1/CanvasModulate".color = Color('635b00')
	
	pass # Replace with function body.
