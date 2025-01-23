extends EnemyState

@export var Minimum : float
@export var Maximum : float

var _time_until_finished = Global.timeElapsed+randf_range(Minimum, Maximum)

func enter(_previous_state_path: String, _data := {}) -> void:
	var tween := create_tween()
	tween.tween_property(enemy, "velocity", Vector3.ZERO, 0.8)

#func exit():

func physics_update(delta: float) -> void:
	enemy.velocity.y -= 9.81 * delta
	enemy.move_and_slide()
	
	if Global.timeElapsed >= _time_until_finished:
		finished.emit(finished_state)
