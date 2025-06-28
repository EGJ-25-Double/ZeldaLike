class_name InventoryUtils
extends Object

static var is_inventory_open: bool:
	set(value):
		is_inventory_open = value
		_on_value_set(value, _on_inventory_opened)

static var item_a: ItemMemo:
	set(value):
		item_a = value
		print("item a: " + ("null" if value == null else value.name))
		_on_value_set(value, _on_item_a_equipped)

static var item_b: ItemMemo:
	set(value):
		item_b = value
		print("item b: " + ("null" if value == null else value.name))
		_on_value_set(value, _on_item_b_equipped)

static var _on_inventory_opened: Array[Callable]
static var _on_item_a_equipped: Array[Callable]
static var _on_item_b_equipped: Array[Callable]

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

static func _on_value_set(value, callables: Array[Callable]) -> void:
	for callable in callables:
		callable.call(value)

static func _subscribe_to(callable: Callable, callables: Array[Callable], value) -> void:
	if callables.has(callable): return
	callables.append(callable)
	callable.call(value)

static func _unsubscribe_from(callable: Callable, callables: Array[Callable]) -> void:
	if !callables.has(callable): return
	callables.erase(callable)
