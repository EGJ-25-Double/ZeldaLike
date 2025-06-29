class_name ScreenFlasher
extends Control


var tween: Tween


func _ready() -> void:
	Events.trap_triggered.connect(_on_trap_triggered)


func _exit_tree() -> void:
	Events.trap_triggered.disconnect(_on_trap_triggered)


func _on_trap_triggered() -> void:
	if tween != null && tween.is_valid() && tween.is_running():
		tween.kill()
	tween = get_tree().create_tween()
	modulate = Color.WHITE
	tween.tween_property(self, "modulate", Color.TRANSPARENT, .5)
	tween.play()
