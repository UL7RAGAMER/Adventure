extends CharacterBody2D
var ani_lock = false
@onready var player = $"../../Player"
var bullet = preload("res://Level/wasp_bullet.tscn")
var num = 1
var health = 3
signal wasp_h
var ishit= false
func _process(delta):
	idle()
	if health <= 0:
		queue_free()
		
	
	var pos = ($".".global_position - player.global_position)

	if pos.x >0:
		$AnimatedSprite2D.flip_h = false
	elif pos.x <0:
		$AnimatedSprite2D.flip_h = true
	if pos <= Vector2(150,-70) and pos >= Vector2(-150,70):
		if num == 1 and (not ishit) :
			ani_lock = true
			atk()

func idle():

	if ani_lock == false:
		$AnimatedSprite2D.play("idle")
func atk():
	$AnimatedSprite2D.play("atk")
	await $AnimatedSprite2D.animation_finished
	var bul = bullet.instantiate() as Node2D
	var direc = ($"/root/Level/Player/Marker2D".global_position - $".".global_position).normalized()
	
	bul.direction = direc
	bul.rotation_degrees = rad_to_deg(direc.angle())
	bul.position =  $".".position
	num+=1
	$"..".add_child(bul)
	bul.w_hurt.connect(_waspplayerhurt)
	ani_lock = false




func _on_timer_timeout():
	num = 1
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	ishit=true
	health -= PlayerPos.dmg
	ani_lock = true
	$AnimatedSprite2D.play("hurt")
	await $AnimatedSprite2D.animation_finished
	pass
func _waspplayerhurt():
	wasp_h.emit(1)


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == 'hurt':
		print('asd')
		ani_lock = false
		ishit= false
	
	pass # Replace with function body.
