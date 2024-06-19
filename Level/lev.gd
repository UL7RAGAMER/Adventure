extends Node2D
@export var lno : int
@export var h_flip:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = $AnimatedSprite2D2 as AnimatedSprite2D
	if h_flip:
		x.flip_h = true
	else:
		x.flip_h = false
	pass
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
func _on_button_2_pressed():
	var b =  $AnimatedSprite2D2 as AnimatedSprite2D
	PlayerPos.levers[lno] = true
	var x = load('res://Audio/Lever/(Audio) 2024-06-16 12-15-38.mp3')
	sound(x)
	b.play('pulled')
	$Button2.queue_free()
	pass # Replace with function body.
