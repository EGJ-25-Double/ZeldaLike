class_name InventoryList
extends Control

@export var item_list: ItemListMemo
@export var item_ref: PackedScene
@export var container: GridContainer
@export var on_two_lines: bool

var items: Array[InventoryItem]
var items_by_memo: Dictionary[ItemMemo, InventoryItem]
var selected: int:
	set(value):
		if value == selected: return
		if selected > -1:
			items[selected].selected = false
		var count: int = items.size()
		selected = (value + count) % count
		items[selected].selected = true

func _ready() -> void:
	_init_items()
	InventoryUtils.subscribe_to_inventory_opened(_on_inventory_opened)
	InventoryUtils.subscribe_to_item_unlocked(_on_item_unlocked)
	visible = false
	update_item_count()

func _exit_tree() -> void:
	InventoryUtils.unsubscribe_from_inventory_opened(_on_inventory_opened)

func _process(_delta: float) -> void:
	_open()
	if !InventoryUtils.is_inventory_open: return
	_update_selection()
	_select_item()

func _init_items() -> void:
	for item in item_list.items:
		var new_item: InventoryItem = item_ref.instantiate()
		new_item.item = item
		container.add_child(new_item)
		items.append(new_item)
		items_by_memo[item] = new_item
	items[selected].selected = true
	var count: int = items.size()
	container.columns = count / 2 if on_two_lines else count

func _on_inventory_opened(is_open: bool) -> void:
	visible = is_open
	selected = 0

func _on_item_unlocked(item: ItemMemo) -> void:
	if item == null: return
	var temp = items_by_memo[item]
	temp.unlocked = true
	update_item_count()
	if InventoryUtils.item_a == null:
		temp.action = InventoryItem.Action.A
	elif InventoryUtils.item_b == null:
		temp.action = InventoryItem.Action.B

func update_item_count() -> void:
	var count: int = 0
	for item in items:
		if item.unlocked:
			count = count + 1
	
	InventoryUtils.item_count = count

func _open() -> void:
	if Input.is_action_just_pressed("inventory"):
		InventoryUtils.is_inventory_open = !InventoryUtils.is_inventory_open

func _update_selection() -> void:
	if !InventoryUtils.is_inventory_open: return
	if on_two_lines:
		_update_selection_on_two_lines()
	else:
		_update_selection_on_one_line()

func _update_selection_on_two_lines() -> void:
	var half = items.size() / 2
	var h = 0
	var v = 0
	if Input.is_action_just_pressed("left"):
		h -= 1 if (selected + half - 1) % half != half - 1 else half + 1
	if Input.is_action_just_pressed("right"):
		h += 1 if (selected + half + 1) % half != 0 else half + 1
	if Input.is_action_just_pressed("up") || Input.is_action_just_pressed("down"):
		v = half
	selected += h + v

func _update_selection_on_one_line() -> void:
	selected += Input.get_axis("left", "right")

func _select_item() -> void:
	var selected_item = items[selected]
	if !selected_item.unlocked: return
	if Input.is_action_just_pressed("action_a"):
		selected_item.action = InventoryItem.Action.A
	elif Input.is_action_just_pressed("action_b"):
		selected_item.action = InventoryItem.Action.B
