@tool
class_name TrapHandler
extends Node2D


@export_tool_button("Get Children Tiles") var _get_children_tiles_button = _get_children_tiles


@export var spawn: Node2D
@export var traps: Array[TrapTile]


var current_traps: Array[TrapTile]


func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	InventoryUtils.subscribe_to_item_a_equipped(_on_item_equipped)
	InventoryUtils.subscribe_to_item_b_equipped(_on_item_equipped)
	
	print(traps.size())
	for trap in traps:
		trap.body_entered.connect(func(body):
			if !_check_trap(trap):
				_kill()
				return
			current_traps.append(trap)
		)
		
		trap.body_exited.connect(func(body):
			current_traps.erase(trap)
		)

func _exit_tree() -> void:
	if Engine.is_editor_hint(): return
	
	InventoryUtils.unsubscribe_from_item_a_equipped(_on_item_equipped)
	InventoryUtils.unsubscribe_from_item_b_equipped(_on_item_equipped)


func _check_trap(trap: TrapTile) -> bool:
	for item in trap.data.traps[trap.type].items:
		if InventoryUtils.item_a != item && InventoryUtils.item_b != item:
			return false
	return true


func _kill() -> void:
	PlayerHero.instance.global_position = spawn.global_position
	Events.trap_triggered.emit()


func _on_item_equipped(value: ItemMemo):
	for trap in current_traps:
		if !_check_trap(trap):
			_kill()
			return


func _get_children_tiles() -> void:
	traps.clear()
	for child in get_children(true):
		if child is TrapTile:
			traps.append(child)
