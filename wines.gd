extends Node2D
@export var stocks:int
var wine = preload("res://wine.tscn")
var hori = false
var p = Vector2(0,30)
var n_a = null
func _ready():
	for i in range(stocks):
		var x = stocks/2
		var w = wine.instantiate() as RigidBody2D
		w.gravity_scale = x 
		w.position = p
		p = w.position + Vector2(0,30)
		add_child(w)
		if i == 0:
			$PinJoint2D.set_node_b('../'+str(get_path_to(w)))
		else:
			var j = PinJoint2D.new()
			j.angular_limit_enabled =true
			j.angular_limit_upper = 5
			j.angular_limit_lower = -5
			j.scale = Vector2(0.53,0.53)
			j.position = p - Vector2(0,40)
			add_child(j)
			j.set_node_a('../'+str(n_a))
			j.set_node_b('../'+str(get_path_to(w)))
		n_a = get_path_to(w)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
