extends CharacterBody2D

@export var speed = 500
@export var grav = 100
@export var jump = 1000
var dash_speed = 3
var dashing = false
func _physics_process(delta):
	velocity.y += grav + delta
	movement()
	move_and_slide()
	if Input.is_action_just_pressed("dash") and !dashing:
		dash()
		

func movement():
	var mov_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = mov_input * speed
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump
		$jump.play()
	if dashing:
		velocity.x = mov_input * speed * dash_speed

func dash():
		dashing = true
		$Timer.connect("timeout", stop_dash)
		$Timer.start()
		$dash.play()

func stop_dash():
	dashing = false
