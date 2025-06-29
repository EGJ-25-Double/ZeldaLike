extends Interaction

class_name State

@export()
var category: String = "Default"
@export()
var mapLinked: TileMapLayer
@export
var fade: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.room_state_changed.connect(func(eventCat, stateName):
		var active = stateName == name
		if (eventCat == category && mapLinked != null && mapLinked.enabled != active):
			if (fade && !active):
				mapLinked.modulate = Color.WHITE
				var tween = mapLinked.create_tween()
				tween.tween_property(mapLinked, "modulate", Color.TRANSPARENT, .5)
				tween.tween_callback(func():
					mapLinked.enabled = false
				)
				return
				
			mapLinked.enabled = active
			if (fade && active):
				mapLinked.modulate = Color.TRANSPARENT
				var tween = mapLinked.create_tween()
				tween.tween_property(mapLinked, "modulate", Color.WHITE, .5)
	)

func activate() -> void:
	Events.room_state_changed.emit(category, name)

func _internal_interact() -> void:
	activate()
