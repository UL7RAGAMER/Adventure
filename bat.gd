extends CharacterBody2D
var t = 0
var timer = true
var player_vis = false
var t2 = false
@export var hp = 2
@export var dmg = 2
signal atk
var cd = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp<=0:
		Inventory.random_spawn(global_position)
		queue_free()
		
	var player =   $"/root/World/Player".global_position
	if (player - global_position <= Vector2(10,10) and player - global_position >= Vector2(-10,-10)) and cd:
		Hurt.health -=dmg*0
		cd = false
		pass
	var v = (player - global_position)
	var ts = get_local_mouse_position()
	if timer and player_vis:
		velocity = v
		velocity= velocity*randf_range(0,1)*2
		timer = false
		
		
	elif not(player_vis) and t2:
		var x = player.x - global_position.x
		var y = player.y - global_position.y
		velocity = Vector2(randi_range(-x,x),randi_range(-y,y))
		t2 = false
	move_and_slide()
	
	pass








func _on_timer_timeout():
	timer = true
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	var x = str(body)
	var p = 'Player:<CharacterBody2D#' + str($"/root/World/Player".get_instance_id()) +'>'
	if $"/root/World/Player" == body:
		player_vis = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	var x = str(body)
	var p = 'Player:<CharacterBody2D#' + str($"/root/World/Player".get_instance_id()) +'>'
	if $"/root/World/Player" == body:
		player_vis = false
	pass # Replace with function body.

	pass # Replace with function body.


func _on_timer_2_timeout():
	t2 = true
	pass # Replace with function body.



func _on_area_2d_2_area_entered(area):
	hp -= PlayerPos.dmg
	pass # Replace with function body.


func _on_timer_3_timeout():
	cd = true
	pass # Replace with function body.
