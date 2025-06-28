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

func play_movement_animation():
	if DIR_TO_MOVEMENT.keys().has(PlayerUtils.player_dir):
		play(DIR_TO_MOVEMENT[PlayerUtils.player_dir])

		
func play_static_animation(anim_dic: Dictionary):
	if anim_dic.keys().has(animation):
		play(anim_dic[animation])
