class_name ScreenFlasher
extends Control

func _ready() -> void:
	Events.trap_triggered.connect(_on_trap_triggered)

func _exit_tree() -> void:
	Events.trap_triggered.disconnect(_on_trap_triggered)

func _on_trap_triggered() -> void:
	visible = true
	var tween = get_tree().create_tween()
	modulate = Color.WHITE
	tween.tween_property(self, "modulate", Color.TRANSPARENT, .5)
	tween.play()
