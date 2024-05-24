extends Control
@onready var hp = $Hp as Label
@onready var str = $Str as Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp.text =  ": " + str(Inventory.regen)
	str.text = ": " + str(Inventory.str)
	pass
