extends CharacterBody2D

class_name PlayerHero

@onready var animated_sprite_2d: CharacterAnimation = $AnimatedSprite2D

const SPEED = 80000.0

func _physics_process(delta: float) -> void:
	var direction
	if InventoryUtils.is_inventory_open:
		direction = Vector2.ZERO
	else:
		direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity = direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.y = move_toward(velocity.y, 0, SPEED * delta)
	
	if velocity != Vector2.ZERO:
		cache_player_dir()
		animated_sprite_2d.play_movement_animation(PlayerUtils.player_dir)
		move_and_slide()
	else:
		animated_sprite_2d.play_idle_animation(PlayerUtils.player_dir)


func cache_player_dir() -> void:
	if velocity.y > 0:
		PlayerUtils.player_dir = Direction.Down
	elif velocity.y < 0:
		PlayerUtils.player_dir = Direction.Up
	elif velocity.x > 0:
		PlayerUtils.player_dir = Direction.Right
	elif velocity.x < 0:
		PlayerUtils.player_dir = Direction.Left
