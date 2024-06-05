extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category('Stats')
@export var health = 5
@export var speed : float = 100.0
@export var dmg = 4
@onready var ani = $AnimatedSprite2D as AnimatedSprite2D
var cd = true
@onready var t = $Timer as Timer
@export var s1 : AudioStream
@export var s2 : AudioStream
@export var s3 : AudioStream
@export var s4 : AudioStream
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if health <= 0:
		await get_tree().create_timer(0.1).timeout
		Inventory.random_spawn(global_position)
		queue_free()

	if not is_on_floor():
		velocity.y += (gravity) * delta
		
	update()
	move_and_slide()
	pass
func update():

	var dir = 1
	var p = PlayerPos.positionv() - $".".global_position
	if p.normalized() > Vector2.ZERO:
		ani.flip_h = false
		dir = 1
	else:
		ani.flip_h= true
		dir = -1

	if (((p.x < 20 and p.x > 0) or (p.x > -20 and p.x< 0))and((p.y < 20 and p.y > 0) or (p.y > -20 and p.y< 0))):
		var x = Timer.new()
		x.one_shot = true
		x.wait_time= randf_range(0,10)
		add_child(x)
		x.timeout.connect(atk.bind(x))
		x.start()
		velocity.x = 0
		ani.play('atk')
		if cd:
			x.stop()
			t.start()
			Hurt.hurt(dmg)
			hurt()
			x.start()

		cd = false
		
	elif((p.x < 100 and p.x > 0) or (p.x > -100 and p.x< 0))and((p.y < 100 and p.y > 0) or (p.y > -100 and p.y< 0))and not(((p.x < 20 and p.x > 0) or (p.x > -20 and p.x< 0))and((p.y < 20 and p.y > 0) or (p.y > -20 and p.y< 0))):

		velocity.x = 100 * dir
		ani.play('run')

	else:
		velocity.x = 0

		ani.play('idle')
func atk(x):
	x.queue_free()
func hurt():
	var x = AudioStreamPlayer2D.new()
	x.stream = load("res://Audio/Player sfx/ough-47202.mp3")
	x.bus = 'SFX'
	x.volume_db = -10
	add_child(x)
	var one = 1
	if one:
		x.play()
		one = 0
	x.finished.connect(st.bind(x))
func st(x):
	x.queue_free()
func sound(s):
	var x = AudioStreamPlayer2D.new()
	x.stream = s
	x.bus = 'SFX'
	add_child(x)
	var one = 1
	if one:
		x.play()
		one = 0
	x.finished.connect(st2.bind(x))
func st2(x):
	x.queue_free()
func _on_timer_timeout():
	t.stop()
	cd = true
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	health -= PlayerPos.dmg
	sound(s1)
	$AnimatedSprite2D.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("Hit",false) 
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("Hit",false) 	
	
	pass # Replace with function body.
