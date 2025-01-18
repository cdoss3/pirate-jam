extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	$"../../dummy/Movement"["parameters/conditions/is_walking"] = true
	
	
	
	player.current_speed = player.speed
	
func exit():
	$"../../dummy/Movement"["parameters/conditions/is_walking"] = false
	
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
	player.velocity = player.velocity.lerp(direction * player.current_speed , player.ACCELERATION * player.FRICTION * delta)
	player.velocity.y = y_velocity
	
	$"../../dummy/Movement"["parameters/Walk/blend_position"] = input_dir
	
	$"../../dummy/Movement".set("parameters/Walk/0/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	$"../../dummy/Movement".set("parameters/Walk/1/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	$"../../dummy/Movement".set("parameters/Walk/2/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	$"../../dummy/Movement".set("parameters/Walk/3/TimeScale/scale",  player.ACCELERATION * player.FRICTION / 3)
	
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("sprint"):
		finished.emit(RUNNING)
	elif player.velocity == Vector3(0,0,0):
		finished.emit(IDLE)
