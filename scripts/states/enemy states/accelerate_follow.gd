extends EnemyState

@export var Minimum : float
@export var Maximum : float

<<<<<<< Updated upstream
var _time_until_finished = 5.0
=======
var _time_until_finished = 0.3
>>>>>>> Stashed changes
var current_speed : float = 0.0
var acceleration : float = 0.3
var max_speed : float = 10.0

func enter(_previous_state_path: String, _data := {}) -> void:
<<<<<<< Updated upstream
	_time_until_finished = Global.timeElapsed + randf_range(Minimum, Maximum)
=======
	_time_until_finished = Global.timeElapsed + randf_range(Minimum, Maximum) * 1000
>>>>>>> Stashed changes
	current_speed = 0.0

func physics_update(delta: float) -> void:
	if Global.timeElapsed < _time_until_finished:
		# Accelerate towards the player
		current_speed = min(current_speed + acceleration * delta, max_speed)
		var current_location = enemy.global_transform.origin
		var next_location = enemy.nav_agent.get_next_path_position()
		var direction = (next_location - current_location).normalized()
		var new_velocity = direction * current_speed
		
		enemy.nav_agent.set_velocity(new_velocity)
	else:
		# Decelerate after time limit
		current_speed = max(current_speed - acceleration * delta, 0.0)
		if current_speed > 0:
			var current_location = enemy.global_transform.origin
			var next_location = enemy.nav_agent.get_next_path_position()
			var direction = (next_location - current_location).normalized()
			var new_velocity = direction * current_speed
			
			enemy.nav_agent.set_velocity(new_velocity)
		else:
			enemy.nav_agent.set_velocity(Vector3.ZERO)
	
	enemy.nav_agent.target_position = Global.player.position
	enemy.move_and_slide()
