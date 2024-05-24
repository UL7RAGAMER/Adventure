extends Control

@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/Options as Button
@onready var lvl = preload('res://Level/level.tscn')
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_down():
	get_tree().change_scene_to_file('res://Level/level.tscn')
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_options_button_down():
	
	pass # Replace with function body.
