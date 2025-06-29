extends AnimatedSprite2D

class_name CharacterAnimation

const DIR_TO_IDLE = {
	Direction.Down: "idle_down",
	Direction.Up: "idle_up",
	Direction.Left: "idle_left",
	Direction.Right: "idle_right"
}

const DIR_TO_MOVEMENT = {
	Direction.Down: "walk_down",
	Direction.Up: "walk_up",
	Direction.Left: "walk_left",
	Direction.Right: "walk_right"
}

func play_movement_animation(direction: int):
	if DIR_TO_MOVEMENT.keys().has(direction):
		play(DIR_TO_MOVEMENT[direction])

		
func play_idle_animation(direction: int):
	if DIR_TO_IDLE.keys().has(direction):
		play(DIR_TO_IDLE[direction])
