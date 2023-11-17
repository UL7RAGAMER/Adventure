extends CharacterBody2D
signal posi(position)
signal fireball(position,direction )
signal bluefb(position, direction)
signal atk()
signal dead()
const SPEED = 200.0
const dbug = 1
const JUMP_VELOCITY = -400.0
var max_health = PlayerPos.def
var health = max_health 
var hit = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ani_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var can_attacked : bool = true
var can_fb : bool = true
var can_bfb : bool = true
var pf = 10
var can_move = true
var fb_cost = 40
var bfb_cost = 20
var mana = PlayerPos.mana
var x = -1045
var y = 1
var time = 0.1
var can_jump = false	
func _physics_process(delta):

	
	if Input.is_action_just_pressed("Down") and is_on_floor():
		position.y +=5
	$GPUParticles2D.visible = false
	$GPUParticles2D2.visible = false
	$GPUParticles2D.process_material.set_emission_sphere_radius(1)
	if Input.is_key_pressed(KEY_Y):
		$GPUParticles2D.visible = true
		$GPUParticles2D2.visible = true
		$player.play("super")
	
		supre_saiyan()
	else:
		$GPUParticles2D.visible = false
		$GPUParticles2D2.visible = false
		
		rest()

	$"../Hud/Label3".set_text(str(exp1))
	$"../Hud/Label3".set_text(str(exp1))
	if Input.is_action_pressed('xp'):
		gain_xp(1)
	max_health = PlayerPos.def
	$"../Hud/TextureProgressBar3".set_max(exp_req)
	$"../Hud/TextureProgressBar3".set_value(exp1)

	$"../Hud/TextureProgressBar2".set_max(PlayerPos.max_mana)
	$"../Hud/TextureProgressBar".set_max(max_health)
	up_health()
	if health <= 0:
		health = 0
		PlayerPos.dmg_multiplyer = 1
		PlayerPos.max_mana = 100
		PlayerPos.def = 10
		$player.play("dead")

		await $player.animation_finished
		$player.set_frame(7)
		$"../Hud/AnimationTree".play("new_animation")
		await $"../Hud/AnimationTree".animation_finished
		$"../Hud/AnimationTree".play("new_animation")		
		$"../Hud".visible = false
		$".".visible = false
		
		Trasisin.change_scene_to_file("res://Player/game.tscn")
		dead.emit()
	if not is_on_floor():
		velocity.y += (gravity) * delta*dbug
		was_in_air = true
	else:
		
		if was_in_air == true:
			land()	
		was_in_air = false
	# Handle Jump.
	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump == true and $Jump.is_stopped() :
		$Jump.start()
		
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		jump()
		
	if Input.is_action_pressed("hurt"):
		health-=1
	if health != 0 and (not health<0):	
		direction = Input.get_vector("Left", "Right", "None", 'None')
		if direction and can_move:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if Input.is_action_pressed("Right"):
			get_node("attack").set_scale(Vector2(1, 1))
		elif Input.is_action_pressed("Left"): 
			get_node("attack").set_scale(Vector2(-1, 1))
			
	if Input.is_action_just_pressed("fireball") and can_fb:
		if mana > fb_cost:		
			can_fb = false
			var fb_markers  = $Fireball_pos.get_children()
			var selected_marker = fb_markers[randi() % fb_markers.size()]
			var direc_fb = (get_global_mouse_position() - position).normalized()
			print('fireball')
			mana -= fb_cost
			$Fireball_cd.start()
			fireball.emit(selected_marker.global_position, direc_fb)


	if not ani_locked and health!=0 and not health<0:
		if direction.x != 0:
			$player.play("run")
		else:
			$player.play("idle")
			pass	
	$"../Hud/TextureProgressBar2".value = mana

	attack()
	posi.emit(position)	
	inventory()				
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * pf)
	update_direction()
	_on_player_2d_animation_finished()

func inventory():
	if Input.is_action_just_pressed("inventory"):
		print('work')
		if $"../Tutorial/CanvasLayer2".visible == true:
			$"../Tutorial/CanvasLayer2".visible = false
		elif $"../Tutorial/CanvasLayer2".visible == false:
			$"../Tutorial/CanvasLayer2".visible = true

func update_direction():
	if direction.x > 0:
		$player.flip_h = false 
	elif direction.x < 0:
		$player.flip_h = true			
var  was_on_floor = is_on_floor()
func jump():
	velocity.y = JUMP_VELOCITY
	$player.play("jump_start")
	ani_locked = true
	can_jump = false
func  land():
	$player.play('jump_end')
	ani_locked = true
func attack():
	if Input.is_action_just_pressed("Primary Action") and can_attacked:
		var x = randi() % $Node2D.get_child_count()
		var y = $Node2D.get_children()
		y[x].play()
			
		$player.play('atk')
		can_attacked = false
		$attack/sword.set_deferred("disabled",true)
		$Timer.start()
		ani_locked = true
		can_move = false
	

func _on_player_2d_animation_finished():
	if $player.animation == 'jump_end':
		ani_locked = false
	if  $player.animation == "atk":
		$attack/sword.set_deferred("disabled", false)
		

func _on_timer_timeout():
	can_attacked = true # Replace with function body.
	ani_locked = false
	can_move = true
	$attack/sword.set_deferred("disabled",true)


func _on_fireball_cd_timeout():
	can_fb = true
	pass # Replace with function body.


func _on_bluefb_cd_timeout():
	can_bfb = true
	
	# Replace with function body.


func _on_attack_area_entered(area):
	PlayerPos.dmg_change(1)	
	atk.emit()
	pass # Replace with function body.





func _on_timer_2_timeout():

	hit = false # Replace with function body.


func _on_timer_3_timeout():
	pass


func up_health():
	var health_p =$"../Hud/TextureProgressBar"
	health_p.value = health

	





func _on_timer_4_timeout():
	if health<max_health and health!=0:
		health += 1	



func _on_level_hurt(d):
	if hit == false:
		$Timer2.start()		
		hit = true
		health -= d
		#$player.material.set_shader_parameter("alpha",1) 
		$Timer6.start()

	pass 	

	
	


func _on_timer_5_timeout():
	if mana < PlayerPos.max_mana:
		mana +=1
var lvl = 1 
var exp1 = 0
var exp_total = 0
var exp_req = req_xp(lvl + 1)
func req_xp(lvl):
	return pow(lvl,2) + lvl * 10
	
func gain_xp(amount):
	exp_total+= amount
	exp1 += amount
	while exp1 >= exp_req:
		
		exp1 -= exp_req
		lvl_up()
		print(exp1)
func lvl_up():
	lvl += 1
	exp_req = req_xp(lvl + 1)
	$"../Hud/Label".set_text(str(lvl))
	PlayerPos.points += 1
func supre_saiyan():	
	var supre = $GPUParticles2D.process_material.get_param_texture(4).get_curve().get_point_left_tangent(1)
	var supre2 = $GPUParticles2D2.process_material.get_param_texture(4).get_curve().get_point_left_tangent(1)
	if supre <= 0 and supre2 <= 0:
		$GPUParticles2D.process_material.get_param_texture(4).get_curve().set_point_left_tangent(1,x)
		$GPUParticles2D2.process_material.get_param_texture(4).get_curve().set_point_left_tangent(1,x)
		x+=10
	var supre1 = $GPUParticles2D.process_material.get_emission_sphere_radius()
	var supre3 = $GPUParticles2D2.process_material.get_emission_sphere_radius()
	if supre1 <= 250 and supre3<=250:
		$GPUParticles2D.process_material.set_emission_sphere_radius(y)
		$GPUParticles2D2.process_material.set_emission_sphere_radius(y)
		y+=1

	pass
func rest():
	var supre1 = $GPUParticles2D.process_material.get_emission_sphere_radius()
	var supre3 = $GPUParticles2D2.process_material.get_emission_sphere_radius()
	if supre1 <= 250 and supre3 <= 250:
		await get_tree().create_timer(1).timeout
		$GPUParticles2D.process_material.set_emission_sphere_radius(y)
		$GPUParticles2D2.process_material.set_emission_sphere_radius(y)
		y=0
#	var supre = $GPUParticles2D.process_material.get_param_texture(4).get_curve().get_point_left_tangent(1)
#	var supre2 = $GPUParticles2D2.process_material.get_param_texture(4).get_curve().get_point_left_tangent(1)
#	if supre <= 0 and supre2 <= 0:
#		$GPUParticles2D.process_material.get_param_texture(4).get_curve().set_point_left_tangent(1,x)
#		$GPUParticles2D2.process_material.get_param_texture(4).get_curve().set_point_left_tangent(1,x)
#		x =-1045
#


func _on_area_2d_body_entered(body):
	await get_tree().create_timer(0.1).timeout
	health = 0
	pass # Replace with function body.


func _on_timer_6_timeout():
	#$player.material.set_shader_parameter("alpha",0) 
	pass # Replace with function body.


func _on_jump_timeout():
	can_jump = false
	pass # Replace with function body.


func _on_area_2d_body_entered2(body):
	await get_tree().create_timer(0.1).timeout
	health = 0
	pass # Replace with function body.
