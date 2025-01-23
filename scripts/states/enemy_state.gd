# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name EnemyState extends State

@export var finished_state : String

const IDLE = "Idle"
const RUNNING = "Running"
const WALKING = "Walking"
const JUMPING = "Jumping"
const FALLING = "Falling"

var enemy: Enemy


func _ready() -> void:
	print("Ready.")
	await owner.ready
	print("owner Ready.")
	enemy = owner as Enemy
	assert(enemy != null)
