extends AudioStreamPlayer2D

@onready var audio_stream_player_2d_2 = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func _on_finished():
	audio_stream_player_2d_2.play()
	pass # Replace with function body.
