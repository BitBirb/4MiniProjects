extends Area3D

@export var clicks_to_pop : int = 5
@export var size_increase : float = 0.2
@export var score_to_give : int = 1

var manager

func _ready() -> void:
	manager = $".."

func _on_input_event(_camera:Node, event:InputEvent, _event_position:Vector3, _normal:Vector3, _shape_idx:int) -> void:
	if event is not InputEventMouseButton:
		return
	
	var mouse_event := event as InputEventMouseButton

	if mouse_event.button_index != MOUSE_BUTTON_LEFT:
		return

	if not mouse_event.pressed:
		return

	scale += Vector3.ONE * size_increase
	clicks_to_pop -= 1

	if clicks_to_pop == 0:
		manager.increase_score(score_to_give)
		queue_free()
