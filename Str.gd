extends CharacterBody2D
@export var t = 1
@export var a = 10
var piked = false
var t1 = true
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var p = $"/root/World/Player" if $"/root/World/Player" else $"../Marker2D"
	if not(piked):
		sinwave(delta)
		t1 = false
	elif piked :

		velocity = 10*(p.global_position - global_position)
		move_and_slide()
		await get_tree().create_timer(0.4).timeout
		visible = false
		Inventory.str +=1
		Hurt.dmg_m+=1
		queue_free()
	move_and_slide()

	
func sinwave(d):
	var x = global_position.x
	velocity.y = a*sin((2*PI/t)*Time.get_ticks_usec()/10**6)


	pass


func _on_timer_timeout():
	t1 = true
	pass # Replace with function body.


func _mouse_enter():
	piked = true
