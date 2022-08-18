extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var InteractLabel=get_node("/root/Main/UI/InteractLabel")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	InteractLabel.g
#	pass
