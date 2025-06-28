class_name Trigger
extends Area2D

@export var trigger_on_walk: bool
@export var block_no_item: bool = true
@export_flags("All:15", "Left:1", "Up:2", "Right:4", "Down:8") var direction: int
@export var interactions: Array[Interaction]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body) -> void:
	if trigger_on_walk:
		start_all_interactions(null)
	elif body is PlayerHero:
		InventoryUtils.subscribe_to_item_used(_on_item_used)

func _on_body_exited(body) -> void:
	if !trigger_on_walk && body is PlayerHero:
		InventoryUtils.unsubscribe_from_item_used(_on_item_used)

func _on_item_used(item: ItemMemo) -> void:
	if item == null && block_no_item: return
	if !verify_dir(): return
	start_all_interactions(item)

func start_all_interactions(item: ItemMemo) -> void:
	for interaction in interactions:
		interaction.interact(item)

func _get_player_direction() -> int:
	return PlayerUtils.player_dir

func verify_dir() -> bool:
	var player_dir = _get_player_direction()
	var valid = (direction & player_dir) == player_dir;
	return valid
