## Boilerplate class to get full autocompletion and type checks for the `enemy` when coding the enemy's states.
## Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name EnemyState extends State

## State to begin when the current state finishes
@export var finished_state : String

const IDLE = "Idle"
const RUNNING = "Running"
const WALKING = "Walking"
const JUMPING = "Jumping"
const FALLING = "Falling"

var enemy : Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null)
