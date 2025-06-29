extends CharacterAnimation

const DIR_TO_SLEEP = {
	Direction.Down: "sleep_down",
	Direction.Up: "sleep_up",
	Direction.Left: "sleep_left",
	Direction.Right: "sleep_right"
}

const DIR_TO_EXCITED = {
	Direction.Down: "excited_down",
	Direction.Up: "excited_up",
	Direction.Left: "excited_left",
	Direction.Right: "excited_right"
}

func play_sleep_animation(direction: int):
	if DIR_TO_SLEEP.keys().has(direction) && animation != DIR_TO_SLEEP[direction]:
		play(DIR_TO_SLEEP[direction])

func play_excited_animation(direction: int):
	if DIR_TO_EXCITED.keys().has(direction) && animation != DIR_TO_EXCITED[direction]:
		play(DIR_TO_EXCITED[direction])
