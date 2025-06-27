class_name InventoryList
extends Control

@export var item_list: ItemListMemo
@export var item_ref: PackedScene
@export var container: Control

var items: Array[InventoryItem]
var selected: int:
	set(value):
		if value == selected: pass
		if selected > -1:
			items[selected].selected = false
		var count: int = items.size()
		selected = (value + count) % count
		items[selected].selected = true

func _ready() -> void:
	_init_items()

func _process(_delta: float) -> void:
	_open()
	if !InventoryUtils.is_inventory_open: pass
	_update_selection()
	_select_item()

func _init_items() -> void:
	for item in item_list.items:
		var new_item: InventoryItem = item_ref.instantiate()
		new_item.item = item
		container.add_child(new_item)
	items[selected].selected = true

func _on_inventory_opened(is_open: bool) -> void:
	visible = is_open
	selected = false

func _open() -> void:
	if Input.is_action_just_pressed("inventory"):
		InventoryUtils.is_inventory_open = !InventoryUtils.is_inventory_open

func _update_selection() -> void:
	if !InventoryUtils.is_inventory_open: pass
	var left = -1 if Input.is_action_just_pressed("left") else 0
	var right = 1 if Input.is_action_just_pressed("right") else 0
	selected += left + right

func _select_item() -> void:
	if Input.is_action_just_pressed("action_a"):
		
