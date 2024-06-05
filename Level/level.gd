extends Node2D
var fireball:PackedScene = preload("res://Player/fireball.tscn")
#var bluefb:PackedScene = preload("res://Player/bluefb.tscn")
#var bfb_aud:PackedScene = preload("res://Player/bfb_aud.tscn")
#var bfb_ani = preload("res://Player/bfb_ani.tscn")
var boar = load("res://Player/character_body_2d.tscn")
var num = 0
signal hurt()
func _ready():
	pass
signal dmg(dmg) 

func _process(_delta):
	$Hud/Label.text = str(Hurt.health)
	$Hud/Label3.text = str(Hurt.dmg_m)
	pass
	
pass		
func _on_player_fireball(pos, direction):
	print(fireball,12312312313123)
	var fb = fireball.instantiate() as Area2D
	print(fb)
	fb.set_z_index(10)
	fb.position = pos
	fb.rotation_degrees = rad_to_deg(direction.angle())
	fb.direction = direction
	print(fb.position,fb.rotation_degrees,fb.direction)
	$"Level 1".add_child(fb)
	$"Level 1/Fireball/AudioStreamPlayer2D".play()
	await get_tree().create_timer(3).timeout
	$"Level 1/Fireball/fireball".play("fizziling")
	$"Level 1/Fireball/CollisionShape2D".set_deferred("disabled",true)
	
	await $"Level 1/Fireball/fireball".animation_finished
	fb.queue_free()



func _on_player_bluefb(_pos, _dir):

	pass
	#var  bfb = bluefb.instantiate() as Area2D
	#var bfb_aud1 = bfb_aud.instantiate() as AudioStreamPlayer2D
	#var bfb_ani1 = bfb_ani.instantiate() as AnimatedSprite2D
	#bfb.position = pos
	#bfb_aud1.position = pos
	#bfb_ani1.position = pos
	#bfb.rotation_degrees = rad_to_deg(dir.angle())
	#bfb_aud1.rotation_degrees = rad_to_deg(dir.angle())
	#bfb_ani1.rotation_degrees = rad_to_deg(dir.angle())
	#bfb.direction = dir
	#bfb_aud1.direction = dir
	#bfb_ani1.direction = dir
	#$Tutorial/Fireballs.add_child(bfb)
	#$Tutorial/Fireballs.add_child(bfb_aud1)
	#$Tutorial/Fireballs.add_child(bfb_ani1)	
	#
	#await get_tree().create_timer(6.671).timeout
	#bfb.queue_free()
#




func _on_character_body_2d_player_hurt():
	hurt.emit(0)
	



func _on_button_pressed():
	if PlayerPos.points > 0:
		PlayerPos.points -= 1
		PlayerPos.dmg_multi_changer('yes')
		var stat_dmg = PlayerPos.dmg_multiplyer
		
		$Tutorial/CanvasLayer2/Control/Panel2/Control/Label.set_text(str(stat_dmg))
	


func _on_button_2_pressed():
	if PlayerPos.dmg_multiplyer !=1:
		PlayerPos.points += 1
		PlayerPos.dmg_multi_changer('no')
		
		if PlayerPos.dmg_multiplyer <=0:
			PlayerPos.dmg_multi_changer('z')
			
		var stat_dmg = PlayerPos.dmg_multiplyer
		$Tutorial/CanvasLayer2/Control/Panel2/Control/Label.set_text(str(stat_dmg))
		
		pass # Replace with function body.


func _on_button_3_pressed():
	if PlayerPos.points > 0:
		PlayerPos.points -= 1
		PlayerPos.mana_change('yes')
		
		if PlayerPos.max_mana <=100:
			PlayerPos.mana_change('z')
			
		var stat_mana = PlayerPos.max_mana
		stat_mana = round(stat_mana)
		$Tutorial/CanvasLayer2/Control/Panel2/Control2/Label2.set_text(str(stat_mana))
		pass # Replace with function body.


func _on_button_4_pressed():
	if PlayerPos.max_mana != 100:
		PlayerPos.points += 1
		await get_tree().create_timer(0.1).timeout
		if PlayerPos.max_mana <=100:
			PlayerPos.mana_change('z')
		else:
			PlayerPos.mana_change('no')
		

		var stat_mana = PlayerPos.max_mana
		stat_mana = round(stat_mana)
		$Tutorial/CanvasLayer2/Control/Panel2/Control2/Label2.set_text(str(stat_mana))
	pass # Replace with function body.


func _on_button_5_pressed():
	if PlayerPos.points > 0:
		PlayerPos.points -= 1

		PlayerPos.defense_change('yes')
		

		var stat_def = PlayerPos.def
		$Tutorial/CanvasLayer2/Control/Panel2/Control3/Label3.set_text(str(stat_def))

		pass # Replace with function body.


func _on_button_6_pressed():
	if PlayerPos.def != 10:
		PlayerPos.points += 1
		if PlayerPos.def <=10:
			PlayerPos.defense_change('z')
		else:
			PlayerPos.defense_change('no')
		

		var stat_def = PlayerPos.def

		$Tutorial/CanvasLayer2/Control/Panel2/Control3/Label3.set_text(str(stat_def))
	
	pass # Replace with function body.


func _on_boar_player_hurt_1():
	hurt.emit(0)
	pass # Replace with function body.


func _on_player_dead():
	PlayerPos._dead()
	pass # Replace with function body.


func _on_wasp_wasp_h(_h):
	hurt.emit(0)
	
	
	pass # Replace with function body.




func _on_visible_on_screen_notifier_2d_screen_entered():
	$Tutorial.visible = true
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	$Tutorial.visible = false
	
	pass # Replace with function body.


func _on_goblin_atk():
	hurt.emit(2)
	pass # Replace with function body.
func _on_skeleton_atk():
	print('asdasd')
	hurt.emit(3)
