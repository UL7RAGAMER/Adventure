extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category('Stats')
@export var health = 5
@export var speed : float = 100.0
@export var dmg = 3
@export var arrow = preload("res://Enemy/Arrow.tscn")
@export_category('Ai')
@export var anitree: AnimationTree
var is_atked = false
signal atks
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <=0:
		queue_free()
	if not is_on_floor():
		velocity.y += (gravity) * delta
	else:
		velocity.y = 0
	

		pass

	update(delta)
	move_and_slide()
	pass
func atk(d):
	var ar = arrow.instantiate() as CharacterBody2D
	$Arrow.add_child(ar)
	ar.atk_s.connect(atkk)
	
	
func update(d):
	var pos = PlayerPos.positionv() - $".".global_position
	var dir = (PlayerPos.positionv() - $".".global_position).normalized()
	if dir.x < 0:
		anitree.set('parameters/Idle/transition_request','L')
	else:
		anitree.set('parameters/Idle/transition_request','R' )

	
	if (((pos.x < 210 and pos.x > 0) or (pos.x > -210 and pos.x< 0))and((pos.y < 210 and pos.y > 0) or (pos.y > -210 and pos.y< 0))) :
		if not(is_atked):
			if dir.x < 0:
				anitree.set('parameters/Atk/transition_request','L')
				print('L', is_atked)
			elif dir.x>0:
				anitree.set('parameters/Atk/transition_request','R')
				print('R', is_atked)
			anitree.set('parameters/State/transition_request','Atk')
			is_atked = true
			atk(d)
	else:

		anitree.set('parameters/State/transition_request','Idle')
		if dir.x < 0:
			anitree.set('parameters/Idle/transition_request','L')
		else:
			anitree.set('parameters/Idle/transition_request','R' )


func _on_timer_timeout():
	is_atked=false
	pass # Replace with function body.
	
func atkk():
	atks.emit()


func _on_area_2d_area_entered(area):
	health -= PlayerPos.dmg
	$Sprite2D.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.material.set_shader_parameter("Hit",false) 
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.material.set_shader_parameter("Hit",false) 
	pass # Replace with function body.
