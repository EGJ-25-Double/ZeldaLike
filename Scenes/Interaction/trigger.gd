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

@export var trigger_on_walk: bool
@export_flags("All:15", "Left:1", "Up:2", "Right:4", "Down:8") var direction: int
@export var interactions: Array[Interaction]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body) -> void:
	if trigger_on_walk:
		start_all_interactions()
	elif body is PlayerHero:
		InventoryUtils.subscribe_to_item_used(_on_item_used)

func _on_body_exited(body) -> void:
	if !trigger_on_walk && body is PlayerHero:
		InventoryUtils.unsubscribe_from_item_used(_on_item_used)

func _on_item_used(item: ItemMemo) -> void:
	if item == null: return
	print("trigger triggered")
	var dir: Direction = direction as Direction
	print(_get_player_direction())
	print(dir)
	print(dir == _get_player_direction())
	if dir != Direction.None && dir != _get_player_direction(): return
	print("trigger triggered with good direction")
	start_all_interactions()

func start_all_interactions() -> void:
	for interaction in interactions:
		interaction.interact(null)

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
