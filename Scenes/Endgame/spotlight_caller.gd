extends Interaction

@export var manager: SpotlightManager

func _internal_interact() -> void:
	manager.start_state()
