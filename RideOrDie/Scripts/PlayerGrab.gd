extends KinematicBody

var speed = 8
var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration
var jump = 4.5
var gravity = 9.8
var stick_amount = 10
var mouse_sensitivity = 1

var direction = Vector3()
var velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var grounded = true

var carrying = false
var canCarry = true
onready var crate = preload("res://Scenes/ThrowableCrate.tscn")

onready var InteractLabel=get_node("UI/InteractLabel")
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90)

	direction = Vector3()
	direction.z = -Input.get_action_strength("move_forward") + Input.get_action_strength("move_backward")
	direction.x = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	direction = direction.normalized().rotated(Vector3.UP, rotation.y)
	

func _physics_process(delta):
	InteractLabel.set_visible(false)
	if is_on_floor():
		gravity_vec = -get_floor_normal() * stick_amount
		acceleration = ground_acceleration
		grounded = true
	else:
		if grounded:
			gravity_vec = Vector3.ZERO
			grounded = false
		else:
			gravity_vec += Vector3.DOWN * gravity * delta
			acceleration = air_acceleration
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		grounded = false
		gravity_vec = Vector3.UP * jump
	if Input.is_action_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pass
	if $Head/InteractRayCast.is_colliding():
		var path=$Head/InteractRayCast.get_collider()
		if path.is_in_group("Crate"):
			InteractLabel.set_visible(true)
	if Input.is_action_pressed("use_ability") and $Head/InteractRayCast.is_colliding():
		# Move crate with player 
		var collider = $Head/InteractRayCast.get_collider()
		if collider.is_in_group("Crate") and canCarry == true:
			carrying = true
			collider.queue_free()
			canCarry = false
			yield(get_tree().create_timer(0.5),"timeout")
			canCarry = true
			#collider.set_parent()
	if Input.is_action_pressed("use_ability") and carrying == true and canCarry == true:
		# Drop the box
		carrying = false	
		var crateInstance = crate.instance()
		owner.add_child(crateInstance)
		crateInstance.global_transform = get_node("CrateSpawnPoint").global_transform
		canCarry = false
		yield(get_tree().create_timer(0.5),"timeout")
		canCarry = true
		
	if carrying == true:
		get_node("Box").visible = true
	else:
		get_node("Box").visible = false
		
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	movement.z = velocity.z + gravity_vec.z
	movement.x = velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
