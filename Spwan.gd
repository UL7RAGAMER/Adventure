extends Node2D
var e1:PackedScene = preload("res://Enemy/Goblin.tscn")
var e2:PackedScene = preload("res://Enemy/skeleton.tscn")
var e3:PackedScene = preload("res://bat.tscn")
@export_flags('G','S','B') var test 
@export_range(0,10,1) var times 
var e = []
var a : Array = []
@export var on : bool = true
func _ready():
	if on:
		if test == 1:
			e.append(e1)
		elif test == 2:
			e.append(e2)
		elif test == 4:
			e.append(e3)
		elif test == 3:
			e.append(e2)
			e.append(e1)
		elif test == 6:
			e.append(e2)
			e.append(e3)
		elif test == 5:
			e.append(e1)
			e.append(e3)
		elif test == 7:
			e.append(e1)
			e.append(e2)
			e.append(e3)
		else:
			assert(test,'Spawn checkboxes not ticked')
		var o = $Marker2D.global_position
		var f = $Marker2D2.global_position
		for i in range(o.x,f.x):
			for j in range(o.y,f.y):
				var x = Vector2(i,j)
				a.append(x)
		await get_tree().create_timer(1).timeout 
		for j in range(times):
			for i in e :
				var p = i.instantiate() as CharacterBody2D
				p.global_position = a.pick_random() 
				
				$"/root/World/Level 1/Bat".add_child(p)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):

	pass
