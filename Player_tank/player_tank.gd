extends CharacterBody3D



@onready var muzzle = get_node("tank_turret/tank_gun/Muzzle")
@onready var shell_scene = preload("res://Tank_shell/tank_shell.tscn")
@onready var shot_sound = $tank_turret/tank_gun/AudioStreamPlayer2D
@onready var muzzle_flash = $tank_turret/tank_gun/Muzzle/CPUParticles3D

@onready var camera1 = get_node("tank_turret/Camera3D")
@onready var camera2 = get_node("tank_turret/Camera3D2")
@onready var camera_fpv = get_node("tank_turret/tank_gun/Camera3D3")

@onready var reload_label = $TankInfo/InfoBox/Label
@onready var ammo_label = $TankInfo/Ammo/Label
@onready var health_label = $TankInfo/Health/Label
@onready var power_label = $TankInfo/Power/Label

var FORWARD_SPEED = 1.0
var BACK_SPEED = 1.0
var TURN_SPEED = 0.01

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var Vec3Z = Vector3.ZERO

var health = 1000

var can_fire = true
var reload_timer = 0.0
var reload_time = 5
var ammo_count = 30
var power = 300

var muzzle_flash_visible : bool = false
var muzzle_flash_timer : float = 0.0
var muzzle_flash_duration : float = 0.1



func _physics_process(delta):
	velocity.y -= gravity * delta
	# Handle actions
	handle_movement()
	handle_camera_tank()
	fire_handling(delta)
	#handle_tank_sound()
	shot_power()
	
	
	
func _ready():
	reload_label.text = "Fire!!!"
	health_label.text = str(health)
	ammo_label.text = str(ammo_count)
	power_label.text = str(power)
	


func _process(delta):
	if can_fire and Input.is_action_just_pressed("shoot"):
		show_muzzle_flash()
		
	if muzzle_flash_visible:
		muzzle_flash_timer += delta
		if muzzle_flash_timer >= muzzle_flash_duration:
			hide_muzzle_flash()
			
			
			
func show_muzzle_flash():
	muzzle_flash_visible = true
	muzzle_flash_timer = 0.0
	muzzle_flash.visible = muzzle_flash_visible
	
	
	
func hide_muzzle_flash():
	muzzle_flash_visible = false
	muzzle_flash.visible = muzzle_flash_visible
	
	
	
func handle_camera_tank() -> void:
	if Input.is_action_just_pressed("cam_change"):
		if camera1.current:
			camera2.current = true
		elif Input.is_action_just_pressed("cam_change"):
			camera1.current = true
			
	if Input.is_action_just_pressed("cam_fpv"):
		if camera1.current or camera2.current:
			camera_fpv.current = true	
			
			
			
func fire_handling(delta):
	if Input.is_action_just_pressed("shoot") and can_fire:
		if reload_timer <= 0.0:
			shoot()
			reload_timer = reload_time
			reload_label.text = "Reloading..."
			
	elif ammo_count <= 0:
		can_fire = false
		reload_label.text = "Ammo Empty"
			
	if reload_timer > 0.0:
		reload_timer -= delta
		if reload_timer < 0.0:
			reload_timer = 0.0
			reload_label.text = "Reloaded"
			
			
			
func shoot():
	var shell = shell_scene.instantiate()
	owner.add_child(shell)
	shell.global_transform = muzzle.global_transform
	shell.velocity = Vector3(0, 0, power)

	ammo_count -= 1
	ammo_label.text = str(ammo_count)
	shot_sound.play()
	
	
	
func shot_power():
	if Input.is_action_just_pressed("shot_power_add"):
		power += 100
		power_label.text = str(power)
		
	if Input.is_action_just_pressed("shot_power_decrese"):
		power -= 100
		power_label.text = str(power)
		
		
		
func handle_movement() -> void:
	if Input.is_action_pressed("move_forward") and Input.is_action_pressed("move_back"):
		velocity.x = 0
		velocity.z = 0
	elif Input.is_action_pressed("move_forward"):
		var forwardVector = -Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = forwardVector * FORWARD_SPEED
		
	elif Input.is_action_pressed("move_back"):
		var backwardVector = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
		velocity = backwardVector * BACK_SPEED
		
	else:
		velocity.x = 0
		velocity.z = 0
		
	if Input.is_action_pressed("turn_left") and Input.is_action_pressed("move_back"):
		rotation.z -= Vec3Z.y + TURN_SPEED
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED
		
	elif Input.is_action_pressed("turn_left"):
		rotation.z += Vec3Z.y - TURN_SPEED
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED
		
	if Input.is_action_pressed("turn_right") and Input.is_action_pressed("move_back"):
		rotation.z += Vec3Z.y - TURN_SPEED
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y += Vec3Z.y + TURN_SPEED
		
	elif Input.is_action_pressed("turn_right"):
		rotation.z -= Vec3Z.y + TURN_SPEED
		rotation.z = clamp(rotation.x, -50, 90)
		rotation.y -= Vec3Z.y + TURN_SPEED
		
		
		
	move_and_slide()


