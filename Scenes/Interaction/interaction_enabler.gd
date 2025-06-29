class_name InteractionEnabler
extends Interaction


@export var object: Node
@export var enable: bool


var tween


func _internal_interact() -> void:
	if enable:
		object.process_mode = Node.PROCESS_MODE_PAUSABLE
		if tween != null && tween.is_valid() && tween.is_running():
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.WHITE, .5)
		tween.play()
	else:
		object.process_mode = Node.PROCESS_MODE_DISABLED
		if tween != null && tween.is_valid() && tween.is_running():
			tween.kill()
		tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, .5)
		tween.play()
