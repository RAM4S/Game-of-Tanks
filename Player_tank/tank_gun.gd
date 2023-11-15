extends MeshInstance3D



@onready var gun_move_sound = $AudioStreamPlayer2D2

@export var UP_LIMIT = 5
@export var DOWN_LIMIT = 45
@export var GUN_ROTATION_SPEED = 25.0 


var gun_up: bool = false
var gun_down: bool = false



func _process(delta: float) -> void:
	if Input.is_action_pressed("gun_up") and rotation.x < deg_to_rad(UP_LIMIT):
		var rotation_increment = deg_to_rad(GUN_ROTATION_SPEED * delta)
		rotation.x = min(rotation.x + rotation_increment, deg_to_rad(UP_LIMIT))
		if not gun_up:
			gun_move_sound.play()
			gun_up = true
		gun_down = false
		
	if Input.is_action_pressed("gun_down") and rotation.x > deg_to_rad(-DOWN_LIMIT):
		var rotation_increment = deg_to_rad(GUN_ROTATION_SPEED * delta)
		rotation.x = max(rotation.x - rotation_increment, deg_to_rad(-DOWN_LIMIT))
		if not gun_down:
			gun_move_sound.play()
			gun_down = true
		gun_up = false
	else:
		gun_move_sound.stop()
		gun_up = false
		gun_down = false
		
	
