extends Area3D



var initial_power = 70


var velocity : Vector3 = Vector3.ZERO

var paint_splash_scene = preload("res://paint_splat.tscn")


func _process(delta):
	velocity.y -= gravity * delta * initial_power
	translate(velocity * delta)



func _on_body_entered(body):
	if body is RigidBody3D:
		print("Collision with:", body.name, "at", body.transform.origin)
		marker(body)



func marker(body):
	var paint_splash = paint_splash_scene.instantiate()
	var world_collision_point = body.global_transform.origin
	if paint_splash.is_inside_tree():
		paint_splash.global_transform.origin = world_collision_point
	add_sibling(paint_splash)
	destroy()



func destroy():
	queue_free()
