extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category('Stats')
@export var health = 5
@export var speed : float = 100.0
@export_category('Ai')
var isatking = false
@export var jump_velocity : float = -300.0
@export var ground_detector : Area2D
@export var jump_block : Area2D
@export var flip_node : Node2D
@onready var anitree : AnimationTree = $AnimationTree
@onready var path : Path2D = $Path2D
@export var ray : RayCast2D
var jumped = false
var ground_in_front : bool = true
var iswall = false
signal jp
signal atk
@onready var direc = (%Player.global_position.x - $".".global_position.x )
@export var move_direction : Vector2 = Vector2.RIGHT :  
	set(new_direction):
		if(move_direction != new_direction):
			move_direction = new_direction
			flip_node.scale.x = new_direction.x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	add_to_group('goblins')
func _process(delta):
	ray.target_position = %Player.global_position - global_position

	if ray.get_collider() == %Player:
		iswall = false
	else:
		iswall = true
		
	if health <= 0:
		await get_tree().create_timer(0.1).timeout
		queue_free()
	
	var p = %Player.global_position - $".".global_position

	if not is_on_floor():
		velocity.y += (gravity) * delta
	elif (not ground_detector.has_overlapping_bodies() or (is_on_wall())):
			# If the wall is too high to jump, flip directions
			if(jump_block.has_overlapping_bodies()):
				# Can't jump so try other direction
				move_direction *= -1
			# If facing a floor gap or a jumpable wall, jump
			else:
				pass
	
	update(delta)
	if iswall == false:
		update_path(delta)
	move_and_slide()

	pass
func update(d):
	var pos = %Player.global_position.x - $".".global_position.x
	if ((pos < 210 and pos > 0) or (pos > -210 and pos < 0) ) and jumped == false:
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
		var plp = (%Player.global_position - $Path2D/PathFollow2D/Idle.global_position)
		if ((plp.x < 50 and plp.x > 0) or (plp.x > -50 and plp.x < 0)) and((plp.y < 50 and plp.y > 0) or (plp.y > -50 and plp.y < 0)) and jumped == true :
			#atk.emit()
			pass	
func jump():
	velocity.y += jump_velocity
func update_path(d):
	var r = $Path2D/PathFollow2D.get_progress_ratio()
	var pos = %Player.global_position.x - $".".global_position.x
	var pos2 = path.curve.get_point_position(2)
	var pos1 = path.curve.get_point_position(1)
	var pos0 = path.curve.get_point_position(0)
	var plp = (%Player.global_position - $".".global_position)
	pos1.x = pos2.x/2
	$Path2D/Marker2D.position = pos0	
	$Path2D/Marker2D2.position = pos1
	$Path2D/Marker2D3.position = pos2
	path.curve.set_point_position(1,pos1)
	if jumped == false:
		var p = path.curve.get_point_count()
		
		path.curve.remove_point(3)
		path.curve.remove_point(4)

		if ((pos < 210 and pos > 0) or (pos > -210 and pos < 0)) or isatking == true  :
			isatking = true
			path.curve.set_point_position(2,plp)
			if plp.x < 0: 
				path.curve.set_point_in(1,Vector2(58,0))
				path.curve.set_point_out(1,Vector2(-58,0))
			else:
				path.curve.set_point_in(1,Vector2(-58,0))
				path.curve.set_point_out(1,Vector2(58,0))
			if r <= 0.428 and jumped == false :
				
				attack_j(d)
			elif r == 1 :
				reset(plp)
				
					
			elif r >= 0.428 and jumped == false :
				attack_f(d)
		pass
func attack_j(d):
	var r = $Path2D/PathFollow2D.get_progress_ratio()

	if r <= 0.428:
		$Path2D/PathFollow2D.set_progress_ratio(r + ft(0.45))
	anitree.set('parameters/Change/transition_request','Atk_jump')
	if move_direction.x < 0:
		anitree.set('parameters/Atk_j/transition_request','Atk_flipped')
	else:
		anitree.set('parameters/Atk_j/transition_request','Atk')
	pass
func attack_f(d):
	var r = $Path2D/PathFollow2D.get_progress_ratio()
	if r != 1:
		$Path2D/PathFollow2D.set_progress_ratio(r + ft(0.3))
		anitree.set('parameters/Change/transition_request','Atk_fall')
		if move_direction.x < 0:
			anitree.set('parameters/Atk_f/transition_request','Atk_fliped')
		else:
			anitree.set('parameters/Atk_f/transition_request','Atk')
	
		
		pass
func reset(plp):
	if jumped == false :
		var pos0 = path.curve.get_point_position(0)
		var pos2 = path.curve.get_point_position(2)
		path.curve.clear_points()
		$Path2D/PathFollow2D.set_progress(0)
		var p = $Path2D/Marker2D3.global_position
		$".".global_position = Vector2(p.x,p.y - 10)
		path.curve.add_point(Vector2.ZERO,Vector2.ZERO,Vector2.ZERO,0)
		path.curve.add_point(Vector2(0,-65),Vector2.ZERO,Vector2.ZERO,1)
		path.curve.add_point(plp,Vector2.ZERO,Vector2.ZERO,2)
		jumped = true
		isatking = false
		jp.emit()
func ft(x):
	return 1/(200 * x)
func _on_jp():


	await get_tree().create_timer(3).timeout
	jumped = false
	pass # Replace with function body.




func _on_area_2d_area_entered(area):
	$Label.set_text(str(area))
	health -= PlayerPos.dmg
	$Path2D/PathFollow2D/Idle.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$Path2D/PathFollow2D/Idle.material.set_shader_parameter("Hit",false) 
	await get_tree().create_timer(0.1).timeout
	$Path2D/PathFollow2D/Idle.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$Path2D/PathFollow2D/Idle.material.set_shader_parameter("Hit",false) 

	pass # Replace with function body.




