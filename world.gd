extends Node3D



@onready var main_player = get_node("tank_001")
@onready var player2 = get_node("Player2_tank")

var activePlayer : Node3D



func _ready():
	activePlayer = main_player
	


func _on_button_pressed():
	get_tree().quit()
	


func _on_button_tank_switch_pressed():
	if activePlayer == main_player:
		switch_player(player2)
	else:
		switch_player(main_player)
		


func switch_player(new_player: Node3D):
	if activePlayer != null:
		activePlayer.set_process_input(false)
		disable_all_cameras(activePlayer)

	new_player.set_process_input(true)
	enable_default_camera(new_player)  
	activePlayer = new_player
	


func disable_all_cameras(player: Node3D):
	for camera in player.get_children():
		if camera is Camera3D:
			camera.current = false
			


func enable_default_camera(player: Node3D):
	var defaultCamera = player.get_node_or_null("Camera3D")
	if defaultCamera != null:
		defaultCamera.current = true
	else:
		for camera in player.get_children():
			if camera is Camera3D:
				camera.current = true
				break
