class_name Doggo extends CharacterBody2D


@export var follow_range: int = 500
@export var item_loved: ItemMemo
@export var item_to_fetch: ItemMemo
@export var position_to_fetch: Marker2D
@onready var player_hero: PlayerHero = get_tree().root.get_node("Testmap/PlayerHero")
@onready var animated_sprite_2d: CharacterAnimation = $AnimatedSprite2D


static var instance: Doggo


var speed: int = 300
var roam_time: float = 2.0
var idle_time: float = 1.5
var sleep_time: float = 3.0
var direction: Vector2 = Vector2.ZERO
var facing_direction: int = Direction.Down
var timer: float = 0.0
var state: String = "idle"
var isAsleep: bool = false


func _ready() -> void:
	instance = self


func _physics_process(delta) -> void:
	var player_hero = PlayerHero.instance
	var distance_to_player = self.position.distance_to(player_hero.position)
	if distance_to_player <= follow_range && player_has_required_item(item_loved) && state != "fetch":
		state = "follow"
	match state:
		"roam":
			velocity = direction * speed
			animated_sprite_2d.play_movement_animation(facing_direction)
			move_and_slide()
			timer -= delta
			if timer <= 0:
				state = "idle"
				timer = idle_time
		"idle":
			velocity = Vector2.ZERO
			animated_sprite_2d.play_idle_animation(facing_direction)
			if (isAsleep):
				isAsleep = false
			timer -= delta
			if timer <= 0:
				if (randi() % 100 < 30):
					state = "sleep"
					timer = sleep_time
					return
				choose_new_direction()
				state = "roam"
				timer = roam_time
		"sleep":
			isAsleep = true
			timer -= delta
			animated_sprite_2d.play_sleep_animation(facing_direction)
			if timer <= 0:
				state = "idle"
				timer = idle_time
		"follow":
			if (player_hero):
				direction = (player_hero.position - self.position).normalized()
				cache_facing_dir(direction)
				velocity = direction * (speed + 100)
				animated_sprite_2d.play_movement_animation(facing_direction)
				move_and_slide()
				if !player_has_required_item(item_loved):
					state = "roam"
					timer = roam_time
				if player_has_required_item(item_to_fetch):
					state = "fetch"
		"fetch":
			var fetch_pos = position_to_fetch.position
			direction = (fetch_pos - self.position).normalized()
			cache_facing_dir(direction)
			velocity = direction * (speed + 100)
			animated_sprite_2d.play_movement_animation(facing_direction)
			move_and_slide()
			if abs(fetch_pos.x - self.position.x) < 1.0 && abs(fetch_pos.y - self.position.y) < 1.0:
				velocity = Vector2.ZERO
				cache_facing_dir(direction)


func choose_new_direction():
	var dirs = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
	direction = dirs[randi() % dirs.size()]
	cache_facing_dir(direction)


func follow_player():
	var player_hero = PlayerHero.instance
	if (player_hero):
		direction = (player_hero.position - self.position).normalized()
		cache_facing_dir(direction)
		velocity = direction * (speed + 100)


func player_has_required_item(item: ItemMemo) -> bool:
	return (InventoryUtils.item_a == item || InventoryUtils.item_b == item)


func cache_facing_dir(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			facing_direction = Direction.Right
		else:
			facing_direction = Direction.Left
	else:
		if dir.y > 0:
			facing_direction = Direction.Down
		else:
			facing_direction = Direction.Up
