extends ColorRect
@onready var label = $Label

func _physics_process(delta: float) -> void:
	update_lives()
	
func update_lives():
	label.text = str(Global.health)
