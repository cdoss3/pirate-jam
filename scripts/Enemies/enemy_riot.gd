extends Enemy

@onready var nav_agent = $NavigationAgent3D
@onready var proximity: Area3D = $Proximity


var MAX_SPEED : float = 25.0
var ACCELERATION : float = 3.4 / 60
var FRICTION : float = 2
var current_speed : float = 0.0
var is_player_in_range = false
var is_attacking = false
var player_position

func _ready() -> void:
	projectile_instance = preload("res://scenes/Attacks/MeleeAttack.tscn")
	
	proximity.body_entered.connect(func(body : Node3D) -> void:
		if body is Player:
			is_player_in_range = true)
	proximity.body_exited.connect(func(body : Node3D) -> void:
		if body is Player:
			is_player_in_range = false)
	
func _physics_process(delta: float) -> void:
	velocity.y -= 20 * delta
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * current_speed
	
	if !is_attacking:
		current_speed = min(ACCELERATION + current_speed, MAX_SPEED)
	
	nav_agent.set_velocity(new_velocity)
	
	if is_player_in_range:
		is_attacking = true
		if current_speed < 2:
			#await <?animation>
			attack()
			#await <?animation>
			is_attacking = false
		else:
			current_speed -= current_speed * 0.8
	
	
	move_and_slide()
	#look_at(player_position)


func update_target_location(target_location):
	nav_agent.target_position = target_location
	player_position = target_location


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
