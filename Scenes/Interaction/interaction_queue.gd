class_name InteractionQueue
extends Interaction

@export var interactions: Array[Interaction]

var i: int

func _on_internal_interact() -> void:
	interactions[i]._internal_interact()
	i = (i + 1) % interactions.size()
