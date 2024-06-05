extends Node2D
signal dmg
var m_h = 10
var health =10
var dmg_m = 1
var fs = false
var one = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('fs') and fs == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fs = true
	elif Input.is_action_just_pressed('fs') and fs == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fs = false
	pass
	
func dmg_p(d):

	dmg.emit(d)
	return d
func hurt(d):
	print(d)
	health -= d
	dmg.emit()

func _on_player_fireball(position, direction):
	pass # Replace with function body.
