class_name Interaction
extends Node

@export var needed_item: Array[ItemMemo]
@export var once: bool

var already_interacted: bool

func interact(item: ItemMemo) -> void:
	if needed_item.size() > 0 && !needed_item.has(item): 
		PlayerHero._on_interaction_fail()
		return
	if once && already_interacted: 
		PlayerHero._on_interaction_fail()
		return
	already_interacted = true
	PlayerHero._on_interaction_success()
	_internal_interact()

func _internal_interact() -> void: pass
