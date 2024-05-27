class_name Options
extends Control

@onready var exit = $MarginContainer/VBoxContainer/Exit
signal exit_option
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_up():
	set_process(false)
	exit_option.emit()
	pass # Replace with function body.
