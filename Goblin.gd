extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category('Stats')
@export var health = 3
@export var speed : float = 100.0
@export var dmg = 3
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
var t = true
@onready var direc = (PlayerPos.positionv().x - $".".global_position.x )
@export var move_direction : Vector2 = Vector2.RIGHT :  
	set(new_direction):
		if(move_direction != new_direction):
			move_direction = new_direction
			flip_node.scale.x = new_direction.x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	
	add_to_group('goblins')
func _process(delta):
	var a = ray.get_collider()
	ray.target_position = PlayerPos.positionv() - global_position

	if ray.get_collider() == $"/root/World/Player":
		iswall = false
	else:
		iswall = true
		
	if health <= 0:
		await get_tree().create_timer(0.1).timeout
		queue_free()
		Inventory
		
	
	var p = PlayerPos.positionv() - $".".global_position

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
		movement2(delta)
	move_and_slide()
	



var once = 1
func movement2(d):
	if is_on_floor():
		velocity.x = 0
	var h = global_position.angle_to_point(get_global_mouse_position())
	var t = 5 - $Timer.time_left
	h = deg_to_rad(65)
	var u = (PlayerPos.positionv().x - global_position.x) * tan(h)
	var v =(PlayerPos.positionv().y - global_position.y)* cos(h)**2 - (gravity*0.5)*cos(h)
	
	var r_v = Vector2(u,v -13)
	var rv1 = r_v
	var init = Vector2.ZERO
	var init2 = Vector2.ZERO
	$Line2D.clear_points()
	if jumped == false:
		jumped = true
		velocity = r_v
		$Timer.start()
	$Line2D2.clear_points()	
	for i in 300:
		$Line2D.add_point(init)
		
		r_v.y += gravity*d
		init +=r_v*d
		once = 0
	rv1.y = rv1.y
	rv1.x = rv1.x
	for i in 300:
		$Line2D2.add_point(init2)
		
		rv1.y += gravity*d
		init2 +=rv1*d
		once = 0
	
	pass
func update(d):
	var pos = PlayerPos.positionv().x - $".".global_position.x
	if ((pos < 210 and pos > 0) or (pos > -210 and pos < 0) ) and jumped == false:
		pass

	if is_on_floor():

		direc = (PlayerPos.positionv() - $".".global_position ).normalized()
		move_direction = direc
		anitree.set('parameters/Change/transition_request','Idle' )
		if move_direction.x < 0:
			anitree.set('parameters/Idle/transition_request','Idle 2')
		else:
			anitree.set('parameters/Idle/transition_request','Idle')

		
		
	elif not is_on_floor():
		direc = (PlayerPos.positionv() - $".".global_position ).normalized()
		move_direction = direc
		anitree.set('parameters/Change/transition_request','f_jump' )
		if move_direction.x < 0:
			anitree.set('parameters/f_jump/transition_request','l')
		else:
			anitree.set('parameters/f_jump/transition_request','r')

		var plp = (PlayerPos.positionv() - $Idle.global_position)
		if ((plp.x < 50 and plp.x > 0) or (plp.x > -50 and plp.x < 0)) and((plp.y < 50 and plp.y > 0) or (plp.y > -50 and plp.y < 0)) and jumped == true and t :
			Hurt.health -= dmg
			t = false
			pass	
func jump():
	velocity.y += jump_velocity
func update_path(d):
	var r = $Path2D/PathFollow2D.get_progress_ratio()
	var pos = PlayerPos.positionv().x - $".".global_position.x
	var pos2 = path.curve.get_point_position(2)
	var pos1 = path.curve.get_point_position(1)
	var pos0 = path.curve.get_point_position(0)
	var plp = (PlayerPos.positionv() - $".".global_position)
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
			$CharacterBody2D.global_position = $Path2D/Marker2D3.global_position
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
	return 1/(Engine.get_frames_per_second() * x)
func _on_jp():


	await get_tree().create_timer(3).timeout
	jumped = false
	pass # Replace with function body.




func _on_area_2d_area_entered(area):
	health -= PlayerPos.dmg
	$Idle.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$Idle.material.set_shader_parameter("Hit",false) 
	await get_tree().create_timer(0.1).timeout
	$Idle.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$Idle.material.set_shader_parameter("Hit",false) 	

	pass # Replace with function body.






func _on_timer_timeout():
	jumped = false
	pass # Replace with function body.


func _on_timer_2_timeout():
	t = true
	pass # Replace with function body.
