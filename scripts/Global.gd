extends Node

var player 

## Time elapsed since Global was instantiated
var timeElapsed : float
func _physics_process(delta: float) -> void:
	timeElapsed += delta

## Resets time back as if the program just began
func time_reset() -> int:
	var temp = timeElapsed
	timeElapsed = 0
	return temp
