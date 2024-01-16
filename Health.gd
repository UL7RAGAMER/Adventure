class_name Health
extends Node2D
@export var health : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage(atk):
	if health > 0:
		health -= atk
