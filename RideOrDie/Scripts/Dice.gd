extends RigidBody

var notRolled = true

func _input(event):
	if Input.is_action_pressed("use_ability") and notRolled == true:
		var random = RandomNumberGenerator.new()
		random.randomize()
		rotation = Vector3(random.randi_range(-90,270),random.randi_range(-90,270),random.randi_range(-90,270))
		gravity_scale = 1
		notRolled = false
		yield(get_tree().create_timer(7),"timeout")
		# Check for face that is touching the floor - opposite is the roll
		#get_node("RayCast1").enabled = true
		#get_node("RayCast2").enabled = true
		#get_node("RayCast3").enabled = true
		#get_node("RayCast4").enabled = true
		#get_node("RayCast5").enabled = true
		#get_node("RayCast6").enabled = true
		
		var roll
		if get_node("RayCast1").is_colliding():
			roll = 6
		elif get_node("RayCast2").is_colliding():
			roll = 5
		elif get_node("RayCast3").is_colliding():
			roll = 4
		elif get_node("RayCast4").is_colliding():
			roll = 3
		elif get_node("RayCast5").is_colliding():
			roll = 2
		elif get_node("RayCast6").is_colliding():
			roll = 1
			
		# Pass roll to next level
		#print(roll)
		Global.roll = roll
		
		var character = "Slugger"
		if roll == 3 or roll == 4:
			character = "Dash"
		if roll == 5 or roll == 6:
			character = "Dwayne"
		
		get_parent().get_node("UI/HBoxContainer/Label").text = "You rolled a " + str(roll)+"! \n You will play " + character
		
		yield(get_tree().create_timer(3),"timeout")
		
		get_tree().change_scene("res://Scenes/Level1.tscn")
		
	

