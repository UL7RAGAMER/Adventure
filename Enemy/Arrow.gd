extends CharacterBody2D
@export var ini_v :Vector2
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
signal atk_s
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('arrow')
	var player =   $"/root/World/Player".global_position
	var h = deg_to_rad(65)
	var u = (player.x - global_position.x) * tan(h)
	var v =(player.y - global_position.y)* cos(h)**2 - (gravity*0.5)*cos(h)
	velocity = Vector2(u,v)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = velocity.angle()
	velocity.y += (gravity) * delta
	move_and_slide()
	await  get_tree().create_timer(10).timeout
	queue_free()
	pass
	
	


func _on_area_2d_body_entered(body):
	Hurt.hurt(1)
	hurt()
	
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
	
	pass # Replace with function body.
