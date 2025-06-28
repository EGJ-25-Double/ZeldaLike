class_name Trigger
extends Area2D

enum Direction
{
	None = 0,
	Left = 1 << 0,
	Up = 1 << 1,
	LeftUp = Left | Up,
	Right = 1 << 2,
	RightUp = Right | Up,
	Horizontal = Right | Left,
	UpHorizontal = Horizontal | Up,
	Down = 1 << 3,
	RightDown = Right | Down,
	LeftDown = Left | Down,
	HorizontalDown = Horizontal | Down,
	Vertical = Up | Down,
	All = Horizontal | Vertical
}

@export_flags("All:15", "Left:1", "Up:2", "Right:4", "Down:8") var direction: int
@export var interactions: Array[Interaction]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body) -> void:
	if body is PlayerHero:
		InventoryUtils.subscribe_to_item_used(_on_item_used)

func _on_body_exited(body) -> void:
	if body is PlayerHero:
		InventoryUtils.unsubscribe_from_item_used(_on_item_used)

func _on_item_used(item: ItemMemo) -> void:
	if item == null: return
	if !verify_dir(): return
	for interaction in interactions:
		interaction.interact(item)

func _get_player_direction() -> Direction:
	match PlayerUtils.player_dir:
		Vector2.LEFT: return Direction.Left
		Vector2.RIGHT: return Direction.Right
		Vector2.UP: return Direction.Up
		Vector2.DOWN: return Direction.Down
		Vector2.ONE: return Direction.RightUp
		Vector2(-1, -1): return Direction.LeftDown
		Vector2(-1, 1): return Direction.LeftUp
		Vector2(1, -1): return Direction.RightDown
	return Direction.None

func verify_dir() -> bool:
	var player_dir = _get_player_direction()
	return direction & player_dir
