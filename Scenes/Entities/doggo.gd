class_name Doggo extends CharacterBody2D


@onready var animated_sprite_2d: CharacterAnimation = $AnimatedSprite2D


var speed: int = 50
var roam_time: float = 2.0
var idle_time: float = 1.5
var direction = Vector2.ZERO
var timer = 0.0
var state = "idle"
var isExcited := false


func _physics_process(delta) -> void:
	match state:
		"roam":
			velocity = direction * speed
			animated_sprite_2d.play_movement_animation(velocity)
			move_and_slide()
			timer -= delta
			if timer <= 0:
				state = "idle"
				timer = idle_time
		"idle":
			velocity = Vector2.ZERO
			animated_sprite_2d.play_idle_animation()
			timer -= delta
			if timer <= 0:
				choose_new_direction()
				state = "roam"
				timer = roam_time


func choose_new_direction():
	var dirs = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
	direction = dirs[randi() % dirs.size()]
