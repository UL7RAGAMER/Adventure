extends CanvasLayer
var once = 1

func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.clear_caches()
	$AnimationPlayer.clear_queue()
	Hurt.health = 0
	PlayerPos.dmg_multiplyer = 1
	PlayerPos.max_mana = 100
	PlayerPos.def = 10
	Inventory.str = 0
	Inventory.regen = 0
	Hurt.health=10
	Hurt.dmg_m = 1
	$'root'
	await get_tree().create_timer(0.1).timeout
	Trasisin.visible = true
	if once == 1:
		$AudioStreamPlayer.play()
		once = 2
		$AnimationPlayer.play("new_animation")
	print(once)
	await $AnimationPlayer.animation_finished 
	if once == 2:
		$AnimationPlayer.play_backwards("new_animation")

		get_tree().change_scene_to_file(target)
		once = 3
	await $AnimationPlayer.animation_finished
	$".".visible = false
	once = 1
func playani():
	print('sfd')
	$".".visible = true
	$AnimationPlayer.play("new_animation")

func r_playani():
	print('sfd')
	$".".visible = true
	$AnimationPlayer.play_backwards("new_animation")

