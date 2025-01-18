extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	$"../../dummy/Movement"["parameters/conditions/is_falling"] = true

func exit() -> void:
	$"../../dummy/Movement"["parameters/conditions/is_falling"] = false

func physics_update(delta: float) -> void:
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_forwards", "walk_backwards")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		pass
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.current_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.current_speed)
	var y_velocity = player.velocity.y
	#player.velocity.y = 0.0
	player.velocity = player.velocity.lerp(direction * player.current_speed, player.ACCELERATION * player.FRICTION * delta)
	player.velocity.y = y_velocity

	player.velocity.y -= player.gravity * delta
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(WALKING)
