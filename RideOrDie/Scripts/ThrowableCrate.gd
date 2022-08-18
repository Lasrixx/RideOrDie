extends RigidBody

var throwForce : int = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	var playerRot = get_parent().get_node("PlayerGrab").rotation
	#apply_central_impulse(Vector3(throwForce*playerRot.x,playerRot.y,throwForce*playerRot.z))
	print(playerRot.y)
	print(cos(playerRot.y))
	print(sin(playerRot.y))
	apply_central_impulse(Vector3(-sin(playerRot.y) * throwForce, 1, -cos(playerRot.y) * throwForce))
	#apply_impulse(global_transform.origin, Vector3.FORWARD*throwForce)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
