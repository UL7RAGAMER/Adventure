extends CharacterBody2D
var speed = 50
var run = false
var t = 0.001
var anilocked = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	var pos = %Player.position - position
	var dir = pos.normalized()
	if pos.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif pos.x < 0:
		$AnimatedSprite2D.flip_h = true
	if not is_on_floor():
		velocity.y += (gravity) * delta 

	if (pos.x < 150 and pos.x > 0) or (pos.x > -150 and pos.x < 0) :
		run = true
		position += speed * dir * delta
		anilocked = true
		$AnimatedSprite2D.play("run")
	else:
		velocity = Vector2.ZERO
		pass
	move_and_slide()
