extends Node2D



func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_log_in_button_pressed():
	get_tree().change_scene_to_file("res://log_in_page.tscn")

