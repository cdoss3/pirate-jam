extends Enemy

@onready var nav_agent = $NavigationAgent3D

var SPEED = 5.0

func _ready() -> void:
	projectile_instance = preload("res://scenes/Attacks/MeleeAttack.tscn")

func update_target_location(target_location):
	nav_agent.target_position = target_location


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
