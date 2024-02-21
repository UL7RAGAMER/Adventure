extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category('Stats')
@export var health = 5
@export var speed : float = 100.0
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
	var pos = %Player.global_position.x - $".".global_position.x
	var dir = (%Player.global_position - $".".global_position).normalized()
	if dir.x < 0:
		anitree.set('parameters/Idle/transition_request','L')
	else:
		anitree.set('parameters/Idle/transition_request','R' )

	
	if ((pos < 210 and pos > 0) or (pos > -210 and pos < 0)) :
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
