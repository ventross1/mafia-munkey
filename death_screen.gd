extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.health == 0:
		get_tree().paused = true
		$".".show()


func _on_button_pressed():
	get_tree().paused = false
	$".".hide()
	Global.health = 5
	get_tree().reload_current_scene()
