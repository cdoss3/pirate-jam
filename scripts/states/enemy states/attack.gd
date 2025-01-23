extends EnemyState



func enter(_previous_state_path: String, _data := {}):
	pass

func _physics_process(delta: float) -> void:
	#await animation_player.play("attack_windup")
	enemy.attack()
	#await animation_player.play("attack_recovery")
	finished.emit("ChargeAtPlayer")

func exit():
	pass
