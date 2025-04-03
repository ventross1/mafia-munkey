extends CharacterBody2D

@export var speed = 250
@export var gravity = 300
@export var jump = -200
var dash_speed = 2.5
var dashing = false
var is_attacking = false


@onready var dash_timer = $Timer  # Get Timer node reference


func _ready():
	get_tree().paused = false
	dash_timer.connect("timeout", stop_dash)
	$death_screen.hide()

	

func _input(event):
	if event.is_action_pressed("attack"):
		Global.is_attacking = true
		$AnimatedSprite2D.play("attack")
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump
		$jump.play()
		Global.is_jumping = true
		$AnimatedSprite2D.play("jump")
		

func _physics_process(delta):
	print(Global.is_hit)

	velocity.y += gravity * delta  

	movement()
	move_and_slide()
	if !is_attacking:
		player_animations()

	if Input.is_action_just_pressed("dash") and !dashing:
		dash()




func movement():
	var mov_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = mov_input * speed
	
	if dashing:
		velocity.x = mov_input * speed * dash_speed

func player_animations():
		#on left (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("left") && Global.is_jumping == false && Global.is_dashing == false:
		$AnimatedSprite2D.flip_h = true
		$CollisionShape2D.position.x = 5.5
		$AnimatedSprite2D.play("run")

		#on right (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("right") && Global.is_jumping == false && Global.is_dashing == false:
		$AnimatedSprite2D.flip_h = false
		$CollisionShape2D.position.x = -5.5
		$AnimatedSprite2D.play("run")

	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
	if Global.is_hit == true:
		$AnimatedSprite2D.play("hit")
		


	elif is_on_floor():
		Global.is_jumping = false

func dash():
	dashing = true
	dash_timer.start()  # Start dash timer
	$dash.play()
	$AnimatedSprite2D.play("dash")
	Global.is_dashing = true

func stop_dash():
	dashing = false
	Global.is_dashing = false

func _on_animated_sprite_2d_animation_finished() -> void:
	Global.is_attacking = false
