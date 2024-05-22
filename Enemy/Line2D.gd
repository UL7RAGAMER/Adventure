extends Line2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
@onready var pl = %Player
@onready var gb = $'..'
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update_trajectory(delta):
	var direc = (pl.global_position - gb.global_position )
	var max_points = 250
	clear_points()
	var pos = Vector2.ZERO
	var vel = direc * 100
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
