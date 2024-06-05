extends Node2D
var e1:PackedScene = preload("res://Enemy/Goblin.tscn")
var e2:PackedScene = preload("res://Enemy/skeleton.tscn")
var e3:PackedScene = preload("res://bat.tscn")
var e4:PackedScene = preload('res://goblin_m.tscn')
var e5:PackedScene = preload('res://skele_m.tscn')
@export var sr:int = 0
@export var G_r = false
@export var S_r = false
@export var B = false
@export var G_m = false
@export var S_m = false
@export_range(0,10,1) var times 
var e = []
var a : Array = []
@export var on : bool = true
func _ready():
	if on:
		if G_r:
			e.append(e1)
		if S_r:
			e.append(e2)
		if B:
			pass
		if G_m:
			e.append(e4)
		if S_m:
			e.append(e5)
		if (G_m or G_r or S_m or S_r or B  ) == false:
			var d = false
			assert(d,'Spawn checkboxes not tickedw')
		var o = $Area2D/CollisionShape2D/Marker2D.global_position
		var f = $Area2D/CollisionShape2D/Marker2D2.global_position

		for i in range(o.x,f.x):
			for j in range(o.y,f.y):
				var x = Vector2(i,j)
				a.append(x)
		for j in range(times):
			for i in e :
				var p = i.instantiate() as CharacterBody2D
				await get_tree().create_timer(0.1).timeout 
				p.global_position = a.pick_random()
				p.modulate
				if sr <=5:
					p.health = p.health * 1
					p.dmg = p.dmg * 1
				elif sr>5 and sr<=10:
					p.health = p.health * 2
					p.dmg = p.dmg * 2
				elif sr>10 and sr<=15:
					p.health = p.health * 3
					p.dmg = p.dmg * 3
				$"/root/World/Level 1/Enemy".add_child(p)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):

	pass
