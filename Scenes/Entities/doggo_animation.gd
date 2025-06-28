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


func play_walk_animation(velocity: Vector2):
	if velocity.y > 0:
		play("walk_down")
	elif velocity.y < 0:
		play("walk_up")
	elif velocity.x > 0:
		play("walk_right")
	elif velocity.x < 0:
		play("walk_left")
