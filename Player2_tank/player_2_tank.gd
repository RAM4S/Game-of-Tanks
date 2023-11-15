extends CharacterBody3D



#@onready var muzzle2 = get_node("tank_turret/tank_gun/Muzzle")
#@onready var shell_scene2 = preload("res://Tank_shell/tank_shell.tscn")
#@onready var shot_sound2 = $tank_turret/tank_gun/AudioStreamPlayer2D
#@onready var muzzle_flash2 = $tank_turret/tank_gun/Muzzle/CPUParticles3D

#@onready var camera1_2 = get_node("tank_turret/Camera3D")
#@onready var camera2_2 = get_node("tank_turret/Camera3D2")
#@onready var camera_fpv2 = get_node("tank_turret/tank_gun/Camera3D3")
#@onready var cam4 = shell_scene2

#@onready var reload_label2 = $TankInfo/InfoBox/Label
#@onready var ammo_label2 = $TankInfo/Ammo/Label
#@onready var health_label2 = $TankInfo/Health/Label
#@onready var power_label2 = $TankInfo/Power/Label

@export var FORWARD_SPEED2 = 1.0
@export var BACK_SPEED2 = 1.0
@export var TURN_SPEED2 = 0.01


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var Vec3Z = Vector3.ZERO

#var health2 = 1000

#var can_fire2 = true
#var reload_timer2 = 0.0
#var reload_time2 = 1.0

#var ammo_count2 = 30
#var power2 = 300

#var muzzle_flash_visible2 : bool = false
#var muzzle_flash_timer2 : float = 0.0
#var muzzle_flash_duration2 : float = 0.1




func _physics_process(delta):
	velocity.y -= gravity * delta
	# Handle actions
	#handle_movement()
	#handle_camera_tank()
	#fire_handling(delta)
	#handle_tank_sound()
	#shot_power()
	
	
#func _ready():
	#reload_label.text = "Fire!!!"
	#health_label.text = str(health)
	#ammo_label.text = str(ammo_count)
	#power_label.text = str(power)
	
	###
#func _process(delta):
	#if can_fire2 and Input.is_action_just_pressed("shoot"):
		#show_muzzle_flash()
		
	#if muzzle_flash_visible2:
		#muzzle_flash_timer2 += delta
		#if muzzle_flash_timer2 >= muzzle_flash_duration2:
			#hide_muzzle_flash()
			
			
#func show_muzzle_flash():
	#muzzle_flash_visible2 = true
	#muzzle_flash_timer2 = 0.0
	#muzzle_flash2.visible = muzzle_flash_visible2
	
	
#func hide_muzzle_flash():
	#muzzle_flash_visible2 = false
	#muzzle_flash2.visible = muzzle_flash_visible2
	
	
#func handle_camera_tank() -> void:
	#if Input.is_action_just_pressed("cam_change"):
		#if camera1.current:
			#camera2.current = true
		#elif Input.is_action_just_pressed("cam_change"):
			#camera1.current = true
			
	#if Input.is_action_just_pressed("cam_fpv"):
		#if camera1.current or camera2.current:
			#camera_fpv.current = true	
			
			
#func switch_shellCam():
	#var cam4 = shell_scene.instantiate()
	
	#if Input.is_action_just_pressed("shoot"):
		#if camera1.current:
			#cam4.current = true
			
			
#func fire_handling(delta):
	#if Input.is_action_just_pressed("shoot") and can_fire2:
		#if reload_timer2 <= 0.0:
			#shoot()
			#reload_timer2 = reload_time2
			#reload_label2.text = "Reloading..."
			
	#elif ammo_count2 <= 0:
		#can_fire2 = false
		#reload_label2.text = "Ammo Empty"
			
	#if reload_timer2 > 0.0:
		#reload_timer2 -= delta
		#if reload_timer2 < 0.0:
			#reload_timer2 = 0.0
			#reload_label2.text = "Reloaded"
			
	
			
			
#func shoot():
	#var shell2 = shell_scene2.instantiate()
	#owner.add_child(shell2)
	#shell2.global_transform = muzzle2.global_transform
	#shell2.velocity = Vector3(0, 0, power2)

	#ammo_count2 -= 1
	#ammo_label2.text = str(ammo_count2)
	#shot_sound2.play()
	
	
#func shot_power():
	#if Input.is_action_just_pressed("shot_power_add"):
		#power2 += 100
		#power_label2.text = str(power2)
		
	#if Input.is_action_just_pressed("shot_power_decrese"):
		#power2 -= 100
		#power_label2.text = str(power2)
		
		
func handle_movement() -> void:
	if Input.is_action_pressed("move_forward") and Input.is_action_pressed("move_back"):
		velocity.x = 0
		velocity.z = 0
	elif Input.is_action_pressed("move_forward"):
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = forwardVector * FORWARD_SPEED2
		
	elif Input.is_action_pressed("move_back"):
		var backwardVector = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = backwardVector * BACK_SPEED2
		
	else:
		velocity.x = 0
		velocity.z = 0
		
	if Input.is_action_pressed("turn_left") and Input.is_action_pressed("move_back"):
		rotation.z -= Vec3Z.y + TURN_SPEED2
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED2
		
	elif Input.is_action_pressed("turn_left"):
		rotation.z += Vec3Z.y - TURN_SPEED2
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED2
		
	if Input.is_action_pressed("turn_right") and Input.is_action_pressed("move_back"):
		rotation.z += Vec3Z.y - TURN_SPEED2
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED2
		
	elif Input.is_action_pressed("turn_right"):
		rotation.z -= Vec3Z.y + TURN_SPEED2
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED2
		
		
	move_and_slide()


