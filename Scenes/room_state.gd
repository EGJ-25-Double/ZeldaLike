extends Node

class_name State

@export()
var category: String = "Default"
@export()
var mapLinked: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.room_state_changed.connect(func(eventCat, eventState):
		if (eventCat == category && mapLinked != null):
			mapLinked.enabled = eventState == self
	)

func activate() -> void:
	Events.room_state_changed.emit(category, self)
