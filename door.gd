extends Node2D
@export var doortlever = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ani = $AnimationPlayer as AnimationPlayer
	var count = 0
	for i in PlayerPos.levers:
		if i:
			count+=1
	if count == 5:
		ani.play('new_animation')
		await ani.animation_finished
		queue_free()
	pass
