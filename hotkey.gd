class_name Hotkey
extends Control
@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
@export var action : String='left'


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_key_input(false)
	set_action()
	set_text_key()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func set_action():
	label.text = action
	
	match action:
		'Left':
			label.text = 'Move left'
		'Right':
			label.text = 'Move right'
		'Down':
			label.text = 'Move down'
		'jump':
			label.text = 'Jump'
		'fireball':
			label.text = 'Ranged'
func set_text_key() -> void:
	var action_events = InputMap.action_get_events(action)
	var action_event = action_events[0] as InputEventKey
	var action_keycode =  OS.get_keycode_string(action_event.physical_keycode)
	button.text="%s" % action_keycode


func _on_button_toggled(toggled_on):
	if toggled_on:
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		for i in get_tree().get_nodes_in_group('hotkey_button'):
			if i.action != self.action:
				i = i as Hotkey
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
				pass
	else :
		for i in get_tree().get_nodes_in_group('hotkey_button'):
			if i.action != self.action:
				i = i as Hotkey
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_key()
	pass # Replace with function body.
	
func  _unhandled_key_input(event):
	rebind(event)
	button.toggle_mode= false
	
func rebind(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action,event)
	set_process_unhandled_key_input(false)
	set_text_key()
	set_action()
