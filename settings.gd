extends Control
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@export var s1: AudioStream
@onready var tab_container = $TabContainer as TabContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	tab_container.tab_changed.connect(_on_tab_container_tab_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tab_container_tab_changed(tab):
	audio_stream_player_2d.play()
	pass # Replace with function body.
