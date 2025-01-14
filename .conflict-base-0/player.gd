extends CharacterBody2D

@export var speed = 500
@export var grav = 200

func _physics_process(delta):
	velocity.y += grav + delta
	movement()
	move_and_slide()

func movement():
	var mov_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = mov_input * speed
