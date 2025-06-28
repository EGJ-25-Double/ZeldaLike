class_name PlayerUtils
extends Object

static var player_dir: Vector2:
	set(value):
		if value.x > 0: player_dir.x = 1
		elif value.x < 0: player_dir.x = -1
		else: player_dir.x = 0
		if value.y > 0: player_dir.y = 1
		elif value.y < 0: player_dir.y = -1
		else: player_dir.y = 0
