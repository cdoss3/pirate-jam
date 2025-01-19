
extends Control

@onready var ANIMATION : AnimationPlayer = $AnimationPlayer



func _on_options_button_pressed() -> void:
	ANIMATION.play("option_slideIn")

func _on_close_pressed() -> void:
	ANIMATION.play("option_slideOut")

# ------------------------------------------------------------------------------------------------ #

func _on_info_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://testmap.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)
