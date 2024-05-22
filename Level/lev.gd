@tool
extends Node2D
@export var lno : int
@export var h_flip:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = $AnimatedSprite2D2 as AnimatedSprite2D
	if h_flip:
		x.flip_h = true
	else:
		x.flip_h = false
	pass


func _on_button_2_pressed():
	var b =  $AnimatedSprite2D2 as AnimatedSprite2D
	PlayerPos.levers[lno] = true
	b.play('pulled')
	$Button2.queue_free()
	pass # Replace with function body.
