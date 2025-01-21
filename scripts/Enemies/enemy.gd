extends CharacterBody3D

## Declarations
var current_location
var next_location
#var new_vel
var SPEED = 3.0

## Preloads
@onready var nav_agent := $NavigationAgent3D

func _physics_process(delta: float) -> void:
	current_location = get_global_transform()
	next_location = nav_agent.get_next_path_position()
	var new_vel : Vector3 = (next_location - current_location).normalized() * SPEED
	
	velocity = new_vel
	
	
func update_target_location(target_position):
	nav_agent.get_next_path_position()
