extends CharacterBody3D

@onready var player := get_tree().get_first_node_in_group("Player")

## Declarations
var target 
var local_dest
var direction
var player_pos

## Exports
@export var SPEED = 50.0

## Preloads
@onready var nav_agent := $NavigationAgent3D

func _physics_process(_delta: float) -> void:
	player_pos = player.global_transform
	target = nav_agent.set_target_position(player_pos)
	#nav_agent.get_next_path_position()
	local_dest = target - global_position
	direction = local_dest.normalized
	
	velocity = direction
