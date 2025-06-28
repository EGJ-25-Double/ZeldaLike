class_name InventoryItem
extends Control

enum Action { None, A, B }

@export var action_sprites: ActionSpritesMemo
@export var sprite: Sprite2D
@export var selection: Node

var unlocked: bool:
	set(value): _set_unlocked(value)

var item: ItemMemo:
	set(value): _set_item(value)

var selected: bool:
	set(value): _set_selected(value)

var action: Action:
	set(value): _on_set_action(value)

func _set_item(value: ItemMemo) -> void:
	sprite.texture = value.sprite
	unlocked = value.unlocked_at_start
	selected = false
	pass

func _set_unlocked(value: bool) -> void:
	sprite.modulate = Color.WHITE if value else Color.TRANSPARENT

func _set_selected(value: bool) -> void:
	selection.modulate.a = 1 if value else 0

func set_action(value: Action) -> void:
	match value:
		Action.A:
			match self.action:
				Action.None: InventoryUtils.item_a = item
				Action.A: InventoryUtils.item_a = null
				Action.B:
					InventoryUtils.item_a = item
					InventoryUtils.item_b = null
		Action.B:
			match self.action:
				Action.None: InventoryUtils.item_b = item
				Action.A:
					InventoryUtils.item_a = null
					InventoryUtils.item_b = item
				Action.B: InventoryUtils.item_b = null
	action = value


func _on_set_action(value: Action) -> void:
	pass
