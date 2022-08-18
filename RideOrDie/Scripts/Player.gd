extends KinematicBody

var speed = 8
var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration
var jump = 4.5
var gravity = 9.8
var stick_amount = 10
var mouse_sensitivity = 1
var time_to_shoot=2000
var next_attack_time=0

onready var bar = get_node("UI/progressbar")
var progress = 0
var cooldown = false
var bar_speed = 2

var direction = Vector3()
var velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var grounded = true

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
	if $Head/RayCast.is_colliding() and $Head/RayCast.get_collider().get_parent().is_in_group("Interactibles"):
		InteractLabel.set_visible(true)
	if Input.is_action_pressed("interact") and $Head/RayCast.is_colliding():
		print("collision")
		var collider=$Head/RayCast.get_collider()
		print(collider)
		print(collider.get_path())
		var path=collider.get_parent()
		print(path)
		InteractLabel.set_visible(false)
		path._on_interact()
	var now=OS.get_ticks_msec()
	bar.value = progress
	progress -= bar_speed
	if progress <= 0:
		cooldown = false
	if Input.is_action_pressed("use_ability"):
		if progress<=0 and self.get_node("Head").current:
			$shootGun.play()
			progress=100
			cooldown=true
			#next_attack_time=now+time_to_shoot
			if $Head/GunShoot.is_colliding():
				var collider=$Head/GunShoot.get_collider()
				print(collider)
				if collider.get_parent().is_in_group("Enemy"):
					collider.get_parent().queue_free()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	movement.z = velocity.z + gravity_vec.z
	movement.x = velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
