extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	$"../../dummy/Movement"["parameters/conditions/idle"] = true
	
	player.velocity.x = 0.0
	
func exit():
	$"../../dummy/Movement"["parameters/conditions/idle"] = false

func physics_update(delta: float) -> void:
	player.velocity.y -= player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("walk_right") or Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_forwards") or Input.is_action_pressed("walk_backwards"):
		finished.emit(WALKING)
