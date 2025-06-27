class_name InventoryItem
extends Control

enum Action { None, A, B }

@export var action_sprites: ActionSpritesMemo
@export var sprite: Sprite2D
@export var selection: Node
@export var action_sprite: Sprite2D

var unlocked: bool:
	set(value): _set_unlocked(value)

var item: ItemMemo:
	set(value): _set_item(value)

var selected: bool:
	set(value): _set_selected(value)

var action: Action:
	set(value): _set_action(value)

func _set_item(item: ItemMemo) -> void:
	sprite.texture = item.sprite
	unlocked = item.unlocked_at_start
	selected = false
	pass

func _set_unlocked(unlocked: bool) -> void:
	sprite.modulate = Color.WHITE if unlocked else Color.TRANSPARENT

func _set_selected(selected: bool) -> void:
	selection.modulate.a = 1 if selected else 0

func set_action(action: Action) -> Action:
	var old_action = self.action
	self.action = action
	return old_action

func _set_action(action: Action) -> void:
	pass
