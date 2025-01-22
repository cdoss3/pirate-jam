extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	visible = false


var optionsVisible := false 
func _on_options_button_pressed() -> void:
	if optionsVisible:
		animation_player.play("option_slideOut")
		optionsVisible = false 
	else:
		animation_player.play("option_slideIn")
		optionsVisible = true 


func _on_info_button_pressed() -> void:
	pass


func _on_resume_button_pressed() -> void:
	$"../..".tab_set_visibility(self, false)


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
