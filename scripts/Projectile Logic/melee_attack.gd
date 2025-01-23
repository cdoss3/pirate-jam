extends Area3D

func _ready() -> void:
	await get_tree().create_timer(0.4).timeout
	queue_free()
