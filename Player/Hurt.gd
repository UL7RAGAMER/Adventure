extends Node2D
signal dmg
var health = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dmg_p(d):
	dmg.emit(d)
	return d
