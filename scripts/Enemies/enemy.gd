extends Enemy

@onready var nav_agent = $NavigationAgent3D

var SPEED = 5.0

#func _physics_process(_delta: float) -> void:
	#var current_location = global_transform.origin
	#var next_location = nav_agent.get_next_path_position()
	#var new_velocity = (next_location - current_location).normalized() * SPEED
	#
	#nav_agent.set_velocity(new_velocity)
	#
	#move_and_slide()


func update_target_location(target_location):
	nav_agent.target_position = target_location


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
