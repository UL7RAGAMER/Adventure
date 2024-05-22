extends Node2D
var pressed_buttons = 0

# Called when the node enters the scene tree for the first time.

func _process(delta):
	if PlayerPos.l1 and PlayerPos.l2 and PlayerPos.l3 and PlayerPos.l4 and PlayerPos.l5:
		pass



#func _on_button_toggled(button_pressed):
	#$Lever/AnimatedSprite2D.play("default")
	#print(button_pressed)
	#$Lever/Button.disconnect('toggled',_on_button_toggled)
	#PlayerPos.l1 = true
	#$Lever/Button.queue_free()
	#pass # Replace with function body.
#func _on_button2_toggled(button_pressed):
	#$Lever2/AnimatedSprite2D.play("default")
	#print(button_pressed)
	#$Lever2/Button.disconnect('toggled',_on_button2_toggled)
	#PlayerPos.l2 = true
	#$Lever2/Button.queue_free()
	#pass # Replace with function body.
#func _on_button3_toggled(button_pressed):
	#$Lever3/AnimatedSprite2D.play("default")
	#print(button_pressed)
	#$Lever3/Button.disconnect('toggled',_on_button3_toggled)
	#PlayerPos.l3 = true
	#$Lever3/Button.queue_free()
#func _on_button4_toggled(button_pressed):
	#$Lever4/AnimatedSprite2D.play("default")
	#print(button_pressed)
	#$Lever4/Button.disconnect('toggled',_on_button4_toggled)
	#PlayerPos.l4 = true
	#$Lever4/Button.queue_free()
	#pass # Replace with function body.
#func _on_button5_toggled(button_pressed):
	#$Lever5/AnimatedSprite2D.play("default")
	#print(button_pressed)
	#$Lever5/Button.disconnect('toggled',_on_button5_toggled)
	#PlayerPos.l5 = true
	#$Lever5/Button.queue_free()
	#pass # Replace with function body.
