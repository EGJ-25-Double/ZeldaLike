extends Area2D


@export()
var state: State


func _on_body_entered(_body: Node2D) -> void:
	state.activate()
