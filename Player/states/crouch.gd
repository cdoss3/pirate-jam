extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
		player.scale.y = 0.5
		player.current_speed = player.current_speed / player.crouch_slowdown

func exit() -> void:
	player.scale.y = 1

func physics_update(delta: float) -> void:
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_forwards", "walk_backwards")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		pass
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.current_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, player.current_speed)
	var y_velocity = player.velocity.y
	player.velocity.y = 0.0
	player.velocity = player.velocity.lerp(direction * player.current_speed, player.ACCELERATION * player.FRICTION * delta)
	player.velocity.y = y_velocity
	
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("sprint"):
		finished.emit(RUNNING)
	elif Input.is_action_just_released("crouch"):
		finished.emit(WALKING)
