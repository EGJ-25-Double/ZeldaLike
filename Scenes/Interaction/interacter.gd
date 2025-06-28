class_name Interacter
extends Node

func _process(delta: float) -> void:
	if InventoryUtils.is_inventory_open: return
	if Input.is_action_just_pressed("item_a"):
		InventoryUtils.use_item_a()
	elif Input.is_action_just_pressed("item_b"):
		InventoryUtils.use_item_b()
