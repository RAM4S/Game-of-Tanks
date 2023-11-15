extends Control



var username = ""
var password
var created = false

#signal login_successful


func _on_log_in_pressed():
	if !created:
		username = $username.text
		password = $password.text.sha256_text()
		created = true
		$Label2.text = "Welcome" + " " + username + " " + "your account is created."
		$login.text = "Login"
		$username.text = ""
		$password.text = ""
		print("acccount created")
	else:
		if $username.text == username:
			if $password.text.sha256_text() == password:
				print("login ok")
				#emit_signal("login_ok")
				get_tree().change_scene_to_file("res://main.tscn")
			else:
				print("login fail")
				$Label.text = "Failed to login into account, please check username or password!"
		$Label2.text = ""
