extends PlayerState


func enter(_previous_state_path: String, _data := {}) -> void:
	$"../../dummy/Movement"["parameters/conditions/jump"] = true
	
	if player.jump_count < player.max_jumps:
		player.jump_count += 1
		player.velocity.y = player.jump_impulse

func exit() -> void:
	$"../../dummy/Movement"["parameters/conditions/jump"] = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") && player.jump_count < player.max_jumps-1:
		$"../../dummy/Movement"["parameters/conditions/jump"] = true
		player.jump_count += 1
		player.velocity.y = player.jump_impulse

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

	
		
	if player.velocity.y >= 0:
		finished.emit(FALLING)
