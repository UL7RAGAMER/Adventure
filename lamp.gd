extends Node2D
var chain:PackedScene = preload("res://Texture/chain.tscn")
@export_range(1,10,1) var chains 
var n_a = null
var once = 1
@export var t : Texture
# Called when the node enters the scene tree for the first time.

func _ready():
	var pos = $Node2D/chain2/Marker2D.position
	for i in chains:

		print(chains)
		var c = chain.instantiate() as RigidBody2D
		var m = Sprite2D.new()
		
		
		c.gravity_scale = 1
		$Node2D.add_child(c)
		c.position = pos 
		
		if i == 0:
			$PinJoint2D3.set_node_b('../'+str(get_path_to(c)))
		
			
			pass
		else:
			var j = PinJoint2D.new()
			j.scale = Vector2(0.0053,0.0053)
			add_child(j)
			pos.x+=1
			j.position = pos
			pos.x-=1
			m.texture = t
			m.scale = Vector2(0.053,0.053)
			c.add_child(m)
			j.set_node_a('../'+str(n_a))
			j.set_node_b('../'+str(get_path_to(c)))
		if i == chains - 1:
			c.linear_velocity.y = 9.8
			pass
			print('../../'+str(get_path_to(c)))
			pos.y +=10
			pos.x+=1
			$Lanten.position = pos
			$Lanten/PinJoint2D.set_node_a('../../'+str(get_path_to(c)))
		pos.y += 5
		
		n_a = get_path_to(c)

	pass # Replace with function body.
# ../Node2D/@RigidBody2D@8

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RigidBody2D.global_position = get_global_mouse_position()
	pass
	
	

