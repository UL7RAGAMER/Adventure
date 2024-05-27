extends Control

@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var options = $MarginContainer/HBoxContainer/VBoxContainer/Options as Button
@onready var lvl = preload('res://Level/level.tscn')
@onready var margin_container = $MarginContainer as MarginContainer
@onready var option = $Options as Options
@onready var audio_stream_player_2d = $AudioStreamPlayer2D as AudioStreamPlayer2D
@export var s1 : AudioStream
@export var s2 : AudioStream
# Called when the node enters the scene tree for the first time.
func _ready():
	option.exit_option.connect(on_exit_option)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_down():
	audio_stream_player_2d.stream = s2
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.6).timeout
	get_tree().change_scene_to_file('res://Level/level.tscn')

	pass # Replace with function body.


func _on_exit_button_down():
	audio_stream_player_2d.stream = s1
	audio_stream_player_2d.play()
	get_tree().quit()
	pass # Replace with function body.


func _on_options_button_down():
	audio_stream_player_2d.stream = s1
	audio_stream_player_2d.play()
	margin_container.visible = false
	option.set_process(true)
	option.visible = true
	
	
func on_exit_option():
	audio_stream_player_2d.stream = s1
	audio_stream_player_2d.play()
	await get_tree().create_timer(0.1).timeout
	margin_container.visible = true
	option.visible = false
	
	pass # Replace with function body.

