extends Area2D
@onready var hit_timer = $hit_timer



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.health -= 1
		Global.is_hit = true
		hit_timer.start()

func stop_hit():
	Global.is_hit = false
