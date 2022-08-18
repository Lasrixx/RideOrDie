extends Spatial

onready var playerShoot = preload("res://Scenes/Player.tscn")
onready var playerDash = preload("res://Scenes/PlayerDash.tscn")
onready var playerGrab = preload("res://Scenes/PlayerGrab.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(playerShoot)
	# Get roll from previous scene
	# disable and enable characters depending on value
	var player
	if Global.roll == 1 or Global.roll == 2:
		# Use shooting character
		print("shooting")
		player=get_parent().get_node("Player")
		get_parent().get_node("PlayerDash").queue_free()
		get_parent().get_node("PlayerGrab").queue_free()
		player.set_process(true)
		player.visible=true
		player.get_node("Head").current=true
	elif Global.roll == 3 or Global.roll == 4:
		# Use dashing character
		print("dashing")
		player=get_parent().get_node("PlayerDash")
		get_parent().get_node("PlayerGrab").queue_free()
		get_parent().get_node("Player").queue_free()
		player.set_process(true)
		player.visible=true
		player.get_node("Head").current=true
	else:
		# Use throwing character
		print("throwing")
		player=get_parent().get_node("PlayerGrab")
		get_parent().get_node("Player").queue_free()
		get_parent().get_node("PlayerDash").queue_free()
		player.set_process(true)
		player.visible=true
		player.get_node("Head").current=true
	
	#player=player.add_to_group("Player")
	player.transform = get_parent().get_node("PlayerSpawn").transform
	player.add_to_group("Player")
	player = playerGrab.instance()
	player.transform = get_parent().get_node("PlayerSpawn").transform
