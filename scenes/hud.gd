class_name HUD extends Control


## SELF DEFINED FUNCTIONS
func change_health(amount: int) -> void:
	## Change the health on the HUD overlay
	var current_health = int($PlayerHealth.text)
	current_health += amount
	
	if current_health < 0:
		current_health = 0
	if current_health > 100:
		current_health = 100
	
	$PlayerHealth.text = str(current_health)

func _process(_delta: float):
	#change_health(-1)
	pass
