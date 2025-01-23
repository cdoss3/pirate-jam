class_name Enemy extends CharacterBody3D


var projectile_instance : PackedScene

func attack(instance : PackedScene = projectile_instance):
	var projectile = instance.instantiate() as Node3D
	projectile.rotation = self.rotation

func jump():
	pass

func teleport():
	pass
