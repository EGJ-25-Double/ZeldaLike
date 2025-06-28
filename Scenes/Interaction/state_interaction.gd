class_name StateInteraction
extends Interaction

@export
var state: State

func _internal_interact() -> void:
	state.activate()
