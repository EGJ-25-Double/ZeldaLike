class_name InventoryUtils
extends Object

static var is_inventory_open: bool:
	set(value):
		for callable in _callables:
			callable.call(value)

static var _callables: Array[Callable]

static func subscribe_to_inventory_opened(callable: Callable) -> void:
	if _callables.has(callable): pass
	_callables.append(callable)
	callable.call(is_inventory_open)

static func unsubscribe_from_inventory_opened(callable: Callable) -> void:
	if !_callables.has(callable): pass
	_callables.erase(callable)
