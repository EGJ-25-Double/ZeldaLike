class_name DoggoTranslator
extends Control

@export var translations: DoggoTranslationList
@export var item: ItemMemo
@export var label: Label
@export var doggo: Doggo

var room: String
var states: Dictionary[String, String]
var translation_by_room: Dictionary[String, DoggoTranslation]

func _ready() -> void:
	Events.room_entered.connect(_on_room_entered)
	Events.room_state_changed.connect(_on_state_changed)
	InventoryUtils.subscribe_to_item_used(_on_item_used)
	visible = false
	_inint_translations()

func _exit_tree() -> void:
	Events.room_entered.disconnect(_on_room_entered)
	Events.room_state_changed.disconnect(_on_state_changed)
	InventoryUtils.unsubscribe_from_item_used(_on_item_used)

func _inint_translations() -> void:
	for translation in translations.translations:
		translation_by_room[translation.room] = translation

func _on_room_entered(value: Room) -> void:
	room = value.name
	print("room: " + room)
	visible = false

func _on_state_changed(category: String, state: String) -> void:
	visible = false if visible == false else states.has(category) && states[category] == state
	states[category] = state
	print(category + ": " + state)

func _on_item_used(value: ItemMemo) -> void:
	if value != item: return
	label.text = _set_translation()
	visible = true
	var tween = get_tree().create_tween()
	modulate = Color.TRANSPARENT
	tween.tween_property(self, "modulate", Color.WHITE, .5)
	tween.play()

func _set_translation() -> String:
	if translation_by_room.has(room):
		var translation: DoggoTranslation = translation_by_room[room]
		if translation.category == "":
			return translation.translation
		if states.has(translation.category):
			if states[translation.category] == translation.state:
				return translation.translation
	return "Woof. (Nothing to translate here...)"
