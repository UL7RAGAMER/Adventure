extends Control

@onready var audio_name = $"HBoxContainer/Audio Name"
@onready var label_2 = $HBoxContainer/Label2
@onready var h_slider = $HBoxContainer/HSlider
@export_enum('Master','SFX','Music') var bus_name : String 
var bus_index : int = 0

func _ready():
	get_aud_bus_index()
	set_aud_name()
	set_slider_value()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func set_aud_name():
	audio_name.text = str(bus_name) + ' Volume'
	
	
func set_aud_value():
	label_2.text = str(h_slider.value * 100)
	
func get_aud_bus_index():
	bus_index = AudioServer.get_bus_index(bus_name)
	
	
func set_slider_value():
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_aud_value()
	
func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value))
	set_aud_value()
	pass # Replace with function body.
