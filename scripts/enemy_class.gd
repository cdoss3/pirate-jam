class_name Enemy extends CharacterBody3D

var projectile_scene : PackedScene

@warning_ignore("shadowed_variable")
func attack(projectile_scene : PackedScene) -> void:
	var attack_scene = projectile_scene.instantiate() as Node3D
	attack_scene.rotation = rotation

func jump() -> void:
	pass

func teleport() -> void:
	pass
