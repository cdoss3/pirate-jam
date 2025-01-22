extends Node

var player : Player

var timeElapsed = 0
func _physics_process(delta: float) -> void:
	timeElapsed += delta
