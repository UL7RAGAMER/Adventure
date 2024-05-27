extends Node2D
var str = 0
var regen = 0
var s = preload("res://Str.tscn")
var r = preload("res://Componets/Regen.tscn")
@onready var collect = $collect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$"/root/World/Hud/Stats/Hp".spreload("res://Audio/Player sfx/collectcoin-6075.mp3")et_text(": " + str(regen))
	#$"/root/World/Hud/Stats/Str".set_text(": " + str(str))
	pass
	
func random_spawn(p:Vector2):
	var a = s.instantiate() as CharacterBody2D
	var b = r.instantiate() as CharacterBody2D
	
	var x = [1,2]
	
	var y = x.pick_random() if randi_range(0,100) >=10 else null
	
	if y==1:
		a.global_position = p
		
		$"/root/World/Level 1/Items".add_child(a)
	if y==2:
		b.global_position = p
		$"/root/World/Level 1/Items".add_child(b)
	pass
