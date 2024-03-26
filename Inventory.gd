extends Node2D
var str = 0
var regen = 0
var s = preload("res://Str.tscn")
var r = preload("res://Componets/Regen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"/root/World/Hud/Stats/Hp".set_text(": " + str(regen))
	$"/root/World/Hud/Stats/Str".set_text(": " + str(str))
	pass
	
func random_spawn(p:Vector2):
	var a = s.instantiate() as CharacterBody2D
	var b = r.instantiate() as CharacterBody2D
	
	var x = [a,b]
	
	var y = x.pick_random() if randi_range(0,100) >=10 else null
	print(y)
	if y:
		y.global_position = p
		$"/root/World/Level 1/Items".add_child(y)
	pass
