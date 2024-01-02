extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var speed : float = 100.0
@export var jump_velocity : float = -300.0
@export var ground_detector : Area2D
@export var jump_block : Area2D
@export var flip_node : Node2D
@onready var anitree : AnimationTree = $AnimationTree
var ground_in_front : bool = true
@onready var direc = (%Player.global_position.x - $".".global_position.x )
@export var move_direction : Vector2 = Vector2.RIGHT :  
	set(new_direction):
		if(move_direction != new_direction):
			move_direction = new_direction
			flip_node.scale.x = new_direction.x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.set_text(str(move_direction))
	if not is_on_floor():
		velocity.y += (gravity) * delta
	elif (not ground_detector.has_overlapping_bodies() or (is_on_wall())):
			# If the wall is too high to jump, flip directions
			if(jump_block.has_overlapping_bodies()):
				print('work')
				# Can't jump so try other direction
				move_direction *= -1
			# If facing a floor gap or a jumpable wall, jump
			else:
				jump()
	print(velocity)
	update()
	move_and_slide()
	pass
func update():
	var pos = %Player.global_position.x - $".".global_position.x
	if (pos < 110 and pos > 0) or (pos > -110 and pos < 0)  :
		direc = (%Player.global_position - $".".global_position ).normalized()
		move_direction = direc
		velocity.x = move_direction.x * speed
		anitree.set('parameters/Change/transition_request','atk')
		if move_direction.x < 0:
			anitree.set('parameters/Atk/transition_request','Atk2')
		else:
			anitree.set('parameters/Atk/transition_request','Atk')
	else:
		velocity.x = 0
		anitree.set('parameters/Change/transition_request','Idle' )
		if move_direction.x < 0:
			anitree.set('parameters/Idle/transition_request','Idle 2')
		else:
			anitree.set('parameters/Idle/transition_request','Idle')
func jump():
	velocity.y += jump_velocity
	
