extends Interaction

class_name State

@export()
var category: String = "Default"
@export()
var mapLinked: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.room_state_changed.connect(func(eventCat, stateName):
		if (eventCat == category && mapLinked != null):
			mapLinked.enabled = stateName == name
	)

func activate() -> void:
	Events.room_state_changed.emit(category, name)

func _internal_interact() -> void:
	activate()
