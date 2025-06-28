extends Area2D

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var doggo: Doggo = get_tree().root.get_node("Testmap/Doggo")

func _on_body_entered(body: Node2D) -> void:
	body.global_position = spawn_point.global_position
	doggo.global_position = spawn_point.global_position
