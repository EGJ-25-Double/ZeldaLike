class_name EquippedItems
extends Control

@export var item_a: EquippedItem
@export var item_b: EquippedItem
@export var no_item: ItemMemo

func _ready() -> void:
	InventoryUtils.subscribe_to_item_a_equipped(_on_item_a_equipped)
	InventoryUtils.subscribe_to_item_b_equipped(_on_item_b_equipped)
	InventoryUtils.subscribe_to_item_unlocked(_on_item_unlocked)

func _exit_tree() -> void:
	InventoryUtils.unsubscribe_from_item_a_equipped(_on_item_a_equipped)
	InventoryUtils.unsubscribe_from_item_b_equipped(_on_item_b_equipped)
	InventoryUtils.unsubscribe_from_item_unlocked(_on_item_unlocked)

func _on_item_a_equipped(item: ItemMemo) -> void:
	_on_item_equipped(item, item_a)

func _on_item_b_equipped(item: ItemMemo) -> void:
	_on_item_equipped(item, item_b)

func _on_item_equipped(item: ItemMemo, target: EquippedItem) -> void:
	var memo = item if item != null else no_item
	target.ref.item = memo
	target.ref.unlocked = true

func _on_item_unlocked(item: ItemMemo) -> void:
	if item == null: return
	if item_a.ref.item == no_item:
		_on_item_a_equipped(item)
	elif item_b.ref.item == no_item:
		_on_item_b_equipped(item)
