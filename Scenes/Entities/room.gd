class_name Room
extends Node2D


@export var hidden_door_marker: Marker2D


func _on_player_detector_body_entered(body: Node2D) -> void:
	Events.room_entered.emit(self)
