extends CharacterBody2D
@export var t = 1
@export var a = 10

var piked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var p = $"..".p
	print(p.global_position - global_position)
	if not(piked):
		sinwave()
	else:
		Inventory.inv[$"..".n] =  $"."
		velocity = 10*(p.global_position - global_position)
		move_and_slide()
		await get_tree().create_timer(0.4).timeout
		visible = false

func _mouse_enter():
	piked = true
	
func sinwave():
	var x = global_position.x
	velocity.y = a*sin(2*PI/t * x *Time.get_ticks_usec()/10**6)
	move_and_slide()
func _input(event):
	pass
