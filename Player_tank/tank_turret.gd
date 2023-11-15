extends MeshInstance3D



@onready var turret_sound = $AudioStreamPlayer2D
@export var TURN_SPEED = 35.0


var rotating_left: bool = false
var rotating_right: bool = false



func _process(delta: float) -> void:
	if Input.is_action_pressed("rotate_turret_left"):
		rotate_y(deg_to_rad(TURN_SPEED * delta))
		if not rotating_left:
			turret_sound.play()
			rotating_left = true
		rotating_right = false
		
	elif Input.is_action_pressed("rotate_turret_right"):
		rotate_y(deg_to_rad(-TURN_SPEED * delta))
		if not rotating_right:
			turret_sound.play()
			rotating_right = true
		rotating_left = false
		
	else:
		turret_sound.stop()
		rotating_left = false
		rotating_right = false
