class_name HUD extends Control


## SELF DEFINED FUNCTIONS
func change_health(amount: int) -> void:
	## Change the health on the HUD overlay
	# Get currently displayed health, convert to integer, increment by amount
	var current_health = int($PlayerHealth.text)
	current_health += amount
	
	# Limits to max and min health
	if current_health < 0:
		current_health = 0
	if current_health > 100:
		current_health = 100
	
	# Push changes to text on Label Node
	$PlayerHealth.text = str(current_health)

func set_health(health_amount: int) -> void:
	## Set player health to any integer
	if health_amount < 0:
		$PlayerHealth.text = "0"
	elif health_amount > 100:
		$PlayerHealth.text = "100"
	else:
		$PlayerHealth.text = str(health_amount)

func _process(_delta: float):
	#change_health(-1)
	pass


func _on_player_health_changed(amount) -> void:
	change_health(amount)
