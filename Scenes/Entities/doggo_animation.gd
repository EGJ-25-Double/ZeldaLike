extends CharacterAnimation


const WALK_TO_IDLE = {
	"walk_down": "idle_down",
	"walk_up": "idle_up",
	"walk_left": "idle_left",
	"walk_right": "idle_right"
}


const IDLE_TO_SLEEP: Dictionary = {
	"idle_down": "sleep_down",
	"idle_up": "sleep_up",
	"idle_left": "sleep_left",
	"idle_right": "sleep_right"
}


const SLEEP_TO_IDLE: Dictionary = {
	"idle_down": "sleep_down",
	"idle_up": "sleep_up",
	"idle_left": "sleep_left",
	"idle_right": "sleep_right"
}


func play_roam_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			play("walk_right")
		else:
			play("walk_left")
	else:
		if direction.y > 0:
			play("walk_down")
		else:
			play("walk_up")
