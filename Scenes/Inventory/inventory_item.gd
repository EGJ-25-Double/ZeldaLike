class_name InventoryItem
extends Control

enum Action { None, A, B }

@export var action_sprites: ActionSpritesMemo
@export var sprite: Sprite2D
@export var selection: Node

var unlocked: bool:
	set(value):
		unlocked = value
		_set_unlocked(value)

var item: ItemMemo:
	set(value):
		item = value
		_set_item(value)

var selected: bool:
	set(value):
		selected = value
		_set_selected(value)

var action: Action:
	set(value):
		var old_action = action
		action = value if action != value else Action.None
		match value:
			Action.A:
				match old_action:
					Action.None:
						InventoryUtils.item_a = item
					Action.A:
						InventoryUtils.item_a = null
					Action.B:
						InventoryUtils.item_a = item
						InventoryUtils.item_b = null
			Action.B:
				match old_action:
					Action.None:
						InventoryUtils.item_b = item
					Action.A:
						InventoryUtils.item_b = item
						InventoryUtils.item_a = null
					Action.B:
						InventoryUtils.item_b = null

func _ready() -> void:
	InventoryUtils.subscribe_to_item_a_equipped(_on_item_a_equipped)
	InventoryUtils.subscribe_to_item_b_equipped(_on_item_b_equipped)

func _set_item(value: ItemMemo) -> void:
	sprite.texture = value.sprite
	unlocked = value.unlocked_at_start
	selected = false

func _set_unlocked(value: bool) -> void:
	sprite.modulate = Color.WHITE if value else Color.TRANSPARENT

func _set_selected(value: bool) -> void:
	selection.modulate.a = 1 if value else 0

func _on_item_a_equipped(value: ItemMemo) -> void:
	if action == Action.A && value != item:
		action = Action.None

func _on_item_b_equipped(value: ItemMemo) -> void:
	if action == Action.B && value != item:
		action = Action.None
