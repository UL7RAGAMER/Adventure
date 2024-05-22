extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_category('Stats')
@export var health = 5
@export var speed : float = 100.0
@export var dmg = 4
@onready var ani = $AnimatedSprite2D as AnimatedSprite2D
var cd = true
@onready var t = $Timer as Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if health <= 0:
		await get_tree().create_timer(0.1).timeout
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
		

		velocity.x = 0
		ani.play('atk')
		if cd:
			t.start()
			Hurt.health -= dmg
		cd = false
		
	elif((p.x < 100 and p.x > 0) or (p.x > -100 and p.x< 0))and((p.y < 100 and p.y > 0) or (p.y > -100 and p.y< 0))and not(((p.x < 20 and p.x > 0) or (p.x > -20 and p.x< 0))and((p.y < 20 and p.y > 0) or (p.y > -20 and p.y< 0))):

		velocity.x = 100 * dir
		ani.play('run')

	else:
		velocity.x = 0

		ani.play('idle')


func _on_timer_timeout():
	t.stop()
	cd = true
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	health -= PlayerPos.dmg
	$AnimatedSprite2D.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("Hit",false) 
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("Hit",true) 
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("Hit",false) 	
	
	pass # Replace with function body.
