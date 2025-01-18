# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const WALKING = "Walking"
const JUMPING = "Jumping"
const FALLING = "Falling"
const DASH = "Dash"
const GROUNDSLAM = "Groundslam"
const WALLRUN = "Wallrun"
const CROUCH = "Crouch"
const SLIDE = "Slide"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null)
