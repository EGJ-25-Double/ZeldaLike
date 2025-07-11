class_name InventoryUtils
extends Object

static var is_inventory_open: bool:
	set(value):
		is_inventory_open = value
		_on_value_set(value, _on_inventory_opened)

static var item_a: ItemMemo:
	set(value):
		item_a = value
		_on_value_set(value, _on_item_a_equipped)

static var item_b: ItemMemo:
	set(value):
		item_b = value
		_on_value_set(value, _on_item_b_equipped)
		
static var item_count: int

static var _on_inventory_opened: Array[Callable]
static var _on_item_a_equipped: Array[Callable]
static var _on_item_b_equipped: Array[Callable]
static var _on_item_used: Array[Callable]
static var _on_item_unlocked: Array[Callable]

static func unlock_item(item: ItemMemo) -> void:
	_on_value_set(item, _on_item_unlocked)

static func use_item_a() -> void:
	print("use item: " + (item_a.name if item_a else "none"))
	_on_value_set(item_a, _on_item_used)

static func use_item_b() -> void:
	print("use item: " + (item_b.name if item_b else "none"))
	_on_value_set(item_b, _on_item_used)

static func subscribe_to_inventory_opened(callable: Callable) -> void:
	_subscribe_to(callable, _on_inventory_opened, is_inventory_open)

static func unsubscribe_from_inventory_opened(callable: Callable) -> void:
	_unsubscribe_from(callable, _on_inventory_opened)

static func subscribe_to_item_a_equipped(callable: Callable) -> void:
	_subscribe_to(callable, _on_item_a_equipped, item_a)

static func unsubscribe_from_item_a_equipped(callable: Callable) -> void:
	_unsubscribe_from(callable, _on_item_a_equipped)

static func subscribe_to_item_b_equipped(callable: Callable) -> void:
	_subscribe_to(callable, _on_item_b_equipped, item_b)

static func unsubscribe_from_item_b_equipped(callable: Callable) -> void:
	_unsubscribe_from(callable, _on_item_b_equipped)

static func subscribe_to_item_used(callable: Callable, instalCall: bool = true) -> void:
	_subscribe_to(callable, _on_item_used, null, instalCall)

static func unsubscribe_from_item_used(callable: Callable) -> void:
	_unsubscribe_from(callable, _on_item_used)

static func subscribe_to_item_unlocked(callable: Callable) -> void:
	_subscribe_to(callable, _on_item_unlocked, null)

static func unsubscribe_from_item_unlocked(callable: Callable) -> void:
	_unsubscribe_from(callable, _on_item_unlocked)

static func _on_value_set(value, callables: Array[Callable]) -> void:
	for callable in callables:
		callable.call(value)

static func _subscribe_to(callable: Callable, callables: Array[Callable], value, instaCall: bool = true) -> void:
	if callables.has(callable): return
	callables.append(callable)
	if (instaCall):
		callable.call(value)

static func _unsubscribe_from(callable: Callable, callables: Array[Callable]) -> void:
	if !callables.has(callable): return
	callables.erase(callable)
