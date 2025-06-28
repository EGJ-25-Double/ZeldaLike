class_name InteractionEnabler
extends Interaction

@export var object: Node
@export var enable: bool

func _internal_interact() -> void:
	if enable:
		object.process_mode = Node.PROCESS_MODE_PAUSABLE
		object.show()
	else:
		object.process_mode = Node.PROCESS_MODE_DISABLED
		object.hide()
