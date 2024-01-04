extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed : float = 100.0
@export var jump_velocity : float = -300.0
@export var ground_detector : Area2D
@export var jump_block : Area2D
@export var flip_node : Node2D
@onready var anitree : AnimationTree = $AnimationTree
@onready var path : Path2D = $Path2D

var ground_in_front : bool = true

@onready var direc = (%Player.global_position.x - $".".global_position.x )
@export var move_direction : Vector2 = Vector2.RIGHT :  
	set(new_direction):
		if(move_direction != new_direction):
			move_direction = new_direction
			flip_node.scale.x = new_direction.x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_on_floor():
		velocity.y += (gravity) * delta
	elif (not ground_detector.has_overlapping_bodies() or (is_on_wall())):
			# If the wall is too high to jump, flip directions
			if(jump_block.has_overlapping_bodies()):
				# Can't jump so try other direction
				move_direction *= -1
			# If facing a floor gap or a jumpable wall, jump
			else:
				jump()
	
	update()
	update_path(delta)
	move_and_slide()
	pass
func update():
	var pos = %Player.global_position.x - $".".global_position.x
	if (pos < 210 and pos > 0) or (pos > -210 and pos < 0)  :
		direc = (%Player.global_position - $".".global_position ).normalized()
		move_direction = direc

	else:
		velocity.x = 0
		anitree.set('parameters/Change/transition_request','Idle' )
		if move_direction.x < 0:
			anitree.set('parameters/Idle/transition_request','Idle 2')
		else:
			anitree.set('parameters/Idle/transition_request','Idle')
		$Path2D/PathFollow2D.set_progress_ratio(0)
func jump():
	velocity.y += jump_velocity

func update_path(d):
	var r = $Path2D/PathFollow2D.get_progress_ratio()
	var pos = %Player.global_position.x - $".".global_position.x
	var pos2 = path.curve.get_point_position(2)
	var pos1 = path.curve.get_point_position(1)
	if (pos < 210 and pos > 0) or (pos > -210 and pos < 0)  :
		var plp = (%Player.global_position - $".".global_position)
		
		plp.y = 0
		pos1.x = pos2.x/2
		path.curve.set_point_position(2,plp)
		if plp.x < 0: 
			path.curve.set_point_in(1,Vector2(58,0))
			path.curve.set_point_out(1,Vector2(-58,0))
		else:
			path.curve.set_point_in(1,Vector2(-58,0))
			path.curve.set_point_out(1,Vector2(58,0))
		path.curve.set_point_position(1,pos1)
		if r <= 0.428:
			attack_j(d)
		elif r == 1:
			reset(plp)
			
				
		else:
			attack_f(d)
	pass
func attack_j(d):
	await  get_tree().create_timer(0.2).timeout
	var r = $Path2D/PathFollow2D.get_progress_ratio()
	$Label.set_text(str(r))
	if r <= 0.428:
		$Path2D/PathFollow2D.set_progress_ratio(r + ft(0.45))
	
		
	#Change the animation to fix
	anitree.set('parameters/Change/transition_request','Atk_jump')
	if move_direction.x < 0:
		anitree.set('parameters/Atk_j/transition_request','Atk_flipped')
	else:
		anitree.set('parameters/Atk_j/transition_request','Atk')
	pass
func attack_f(d):
	var r = $Path2D/PathFollow2D.get_progress_ratio()
	if r != 1:
		$Label.set_text(str(r))
		$Path2D/PathFollow2D.set_progress_ratio(r + ft(0.3))
		anitree.set('parameters/Change/transition_request','Atk_fall')
		if move_direction.x < 0:
			anitree.set('parameters/Atk_f/transition_request','Atk_fliped')
		else:
			anitree.set('parameters/Atk_f/transition_request','Atk')
	
		
		
		pass
		
func reset(plp):
	var pos0 = path.curve.get_point_position(0)
	var pos2 = path.curve.get_point_position(2)
	path.curve.remove_point(0)
	path.curve.remove_point(1)
	path.curve.remove_point(2)
	$Path2D/PathFollow2D.set_progress_ratio(0)
	path.curve.add_point(Vector2.ZERO,Vector2.ZERO,Vector2.ZERO,0)
	path.curve.add_point(Vector2(0,-65),Vector2.ZERO,Vector2.ZERO,1)
	path.curve.add_point(plp,Vector2.ZERO,Vector2.ZERO,2)

	pass
func ft(x):
	return 1/(200 * x)
