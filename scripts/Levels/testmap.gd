extends Node3D

@onready var player := $Player

func _physics_process(delta: float) -> void:
	get_tree().call_group("Enemy", "update_target_location", player.position)
