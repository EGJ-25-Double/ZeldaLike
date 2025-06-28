class_name Interaction
extends Node

@export var needed_item: Array[ItemMemo]
@export var once: bool

var already_interacted: bool

func interact(item: ItemMemo) -> void:
	if needed_item.size() > 0 && !needed_item.has(item): return
	if once && already_interacted: return
	already_interacted = true
	_internal_interact()

func _internal_interact() -> void: pass
