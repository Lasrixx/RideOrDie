extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if get_overlapping_bodies().size()>0:
			for i in get_overlapping_bodies():
				if i.name=="PlayerGrab":
					print(i,i.get_parent(),i.is_in_group("Player"))
				if i.is_in_group("Player"):
						Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
						get_tree().change_scene("res://Scenes/TutPlayerGrab.tscn")
