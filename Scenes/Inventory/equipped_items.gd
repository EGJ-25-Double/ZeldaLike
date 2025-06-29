class_name EquippedItems
extends Control

@export var item_a: EquippedItem
@export var item_b: EquippedItem
@export var no_item: ItemMemo
@onready var space_hint: ColorRect = $"Space Hint"


func _ready() -> void:
	InventoryUtils.subscribe_to_item_a_equipped(_on_item_a_equipped)
	InventoryUtils.subscribe_to_item_b_equipped(_on_item_b_equipped)
	InventoryUtils.subscribe_to_item_unlocked(_on_item_unlocked)
	
	on_item_count_updated()

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

func _on_item_unlocked(_item: ItemMemo) -> void:
	call_deferred("on_item_count_updated")
	
func on_item_count_updated() -> void:
	space_hint.visible = InventoryUtils.item_count > 2
