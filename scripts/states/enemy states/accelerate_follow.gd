extends EnemyState

@export var Minimum : float
@export var Maximum : float

var _time_until_finished = Global.timeElapsed+(randf_range(Minimum, Maximum) * 1000)
var current_speed : float
var acceleration := 0.3

func enter(_previous_state_path: String, _data := {}) -> void:
	current_speed = enemy.SPEED

#func exit():

func physics_update(_delta: float) -> void:
	print("test")
	var current_location = enemy.global_transform.origin
	var next_location = enemy.nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * enemy.SPEED
	
	enemy.nav_agent.set_velocity(new_velocity)
	
	enemy.nav_agent.target_position = Global.player.position
	
	enemy.move_and_slide()
	
	#current_speed += acceleration
	
	if Global.timeElapsed >= _time_until_finished:
		finished.emit(finished_state)
