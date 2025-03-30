extends CharacterBody2D

@export var speed = 500
@export var grav = 100
@export var jump = 1000
var dash_speed = 2.5
var dashing = false

@export var wall_jump_force: Vector2 = Vector2(400, -700)
@export var wall_kickback: float = 200  # Small push after wall jump

@onready var trigger = $WallJumpTrigger
@onready var dash_timer = $Timer  # Get Timer node reference

func _ready():
	dash_timer.connect("timeout", stop_dash)

func _physics_process(delta):
	print(velocity.x)
	velocity.y += grav + delta  

	movement()
	move_and_slide()
	
	if Input.is_action_just_pressed("dash") and !dashing:
		dash()
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump
			$jump.play()

func movement():
	var mov_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = mov_input * speed
	
	if dashing:
		velocity.x = mov_input * speed * dash_speed
	
	# Rotate trigger to face movement direction
	if mov_input != 0:
		trigger.rotation = mov_input

func dash():
	dashing = true
	dash_timer.start()  # Start dash timer
	$dash.play()

func stop_dash():
	dashing = false
