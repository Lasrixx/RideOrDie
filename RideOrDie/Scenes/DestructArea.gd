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
		if !get_overlapping_bodies()[0].is_in_group("Walls"):
			for i in get_overlapping_bodies():
				if i.name=="ThrowableCrate":
					get_parent().queue_free()
