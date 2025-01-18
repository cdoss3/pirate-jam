class_name Player extends CharacterBody3D

## SIGNALS
signal health_changed

## PLAYER INFO
var current_health = 50
const max_health = 100

## KINEMATIC DEFAULTS
# Forces
@export var ACCELERATION := 3.4
@export var FRICTION := 1
@export var gravity := 9.81

# Speeds
@export var speed :float= 10
@export var current_speed :float= speed
@export var run_speed := 20
@export var wallrun_speed = 22


## MOUSE/KEYBOARD/INPUT
# Mouse settings
@export var mouse_sensitivity = 0.006

# Player Movement
var jump_count = 0
@export var max_jumps = 3
@export var jump_impulse := 6

@export var dash_ready = true
@export var dash_impulse := 4
@export var dash_cooldown :float= 1

@export var groundslam_impulse := 100

@export var wallrun_dragdown = 0.1
@export var wallrun_resets_jump = true

@export var crouch_slowdown := 2

@export var slide_slowdown := 0.1


## NODE REFERENCES
@onready var fsm := $StateMachine
@onready var label := $Hud/Control/Statelabel
@onready var camera := $FPCam

func _ready():
	#Capture Mouse Movement
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#HUD hide
	$Hud/Control/Statelabel.hide()
	$Hud/Control/Globalposition.hide()
	$Hud/Control/Velocity.hide()
	$Hud/Control/CurrentSpeed.hide()
	
	# Set HUD health amount to current_health
	$"../HUD".set_health(current_health)

func _process(_delta: float) -> void:
	# Quit game on input
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	# Quick input to test player health change signals
	if Input.is_action_just_released("test_input"):
		change_health(20)
		print(current_health)

	update_labels()
	hud_visibility()
	
func _physics_process(_delta: float) -> void:
	if is_on_floor():
		jump_count = 0

func _unhandled_input(event):
	# Handle Mouse Movement
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		# Locks the Camera Movement between specified angles
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(87))

func _on_dash_cooldown_timeout() -> void:
	dash_ready = true

var hud_visible = false
func hud_visibility():
	if Input.is_action_just_pressed("f3") && !hud_visible:
		$Hud/Control/Statelabel.show()
		$Hud/Control/Globalposition.show()
		$Hud/Control/Velocity.show()
		$Hud/Control/CurrentSpeed.show()
		
		hud_visible = true
	elif Input.is_action_just_pressed("f3") && hud_visible:
		$Hud/Control/Statelabel.hide()
		$Hud/Control/Globalposition.hide()
		$Hud/Control/Velocity.hide()
		$Hud/Control/CurrentSpeed.hide()
		
		hud_visible = false
		
func update_labels():
	label.text = "State: " + fsm.state.name
	
	var globaltext = "Globalposition: X: " + "%0.3f" % global_position.x + " Y: " + "%0.3f" % global_position.y + " Z: " + "%0.3f" % global_position.z
	$Hud/Control/Globalposition.text = globaltext
	
	var velotext = "Velocity: X: " + "%0.3f" % velocity.x + " Y: " + "%0.3f" % velocity.y + " Z: " + "%0.3f" % velocity.z
	$Hud/Control/Velocity.text = velotext
	
	$Hud/Control/CurrentSpeed.text = "Current Speed: " + str(current_speed)


## TAKE AND HANDLE DAMAGE FROM ENEMIES
func _on_body_entered():
	pass
	# If damaging thing enters Area3D:
	#	Call change health function

func change_health(amount):
	health_changed.emit(amount)
	current_health += amount
	
	if current_health > max_health:
		current_health = max_health
	if current_health < 0:
		current_health = 0
