extends Node2D
signal dmg
var health = 10
var dmg_m = 1
var fs = false
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


func _on_player_fireball(position, direction):
	pass # Replace with function body.
