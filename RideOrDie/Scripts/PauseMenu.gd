extends Control

var is_paused=false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.is_paused=!is_paused
		visible=is_paused
		if self.is_paused==true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if self.is_paused==false:
			#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func set_is_paused(value):
	is_paused=value
	get_tree().paused=is_paused
	visible=is_paused



func _on_ResumeBtn_pressed():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.is_paused=false




func _on_QuitBtn_pressed():
	get_tree().quit()
