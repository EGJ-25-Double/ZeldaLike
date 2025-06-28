extends Area2D

@onready var spawn_point: Marker2D = $SpawnPoint

func _on_body_entered(body: Node2D) -> void:
	body.global_position = spawn_point.global_position
