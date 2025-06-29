extends Area2D

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var room_change: AudioStreamPlayer = $"../RoomChange"

func _on_body_entered(body: Node2D) -> void:
	room_change.play()
	body.global_position = spawn_point.global_position
	var doggo = Doggo.instance
	if (doggo != null):
		doggo.global_position = spawn_point.global_position
