class_name Doggo extends CharacterBody2D


@export var follow_range: int = 500
@export var item_loved: ItemMemo
@export var item_to_fetch: ItemMemo
@export var room_to_fetch: String
@export var position_to_fetch: Marker2D
@onready var animated_sprite_2d: CharacterAnimation = $AnimatedSprite2D
@onready var doggo_translator: DoggoTranslator = $DoggoTranslator
@onready var collision_shape: CollisionShape2D = $CollisionShape2D



static var instance: Doggo


var speed: int = 500
var roam_time: float = 2.0
var idle_time: float = 1.5
var sleep_time: float = 3.0
var direction: Vector2 = Vector2.ZERO
var facing_direction: int = Direction.Down
var timer: float = 0.0
var state: String = "idle"
var isAsleep: bool = false
var hasFetch: bool = false


func _ready() -> void:
	instance = self
	InventoryUtils.subscribe_to_item_used(_on_item_used)


func _physics_process(delta) -> void:
	var player_hero = PlayerHero.instance
	var distance_to_player = self.position.distance_to(player_hero.position)
	if distance_to_player <= follow_range &&  hasFetch && state != "wait":
		state = "follow"
	match state:
		"roam":
			check_if_collide(delta)
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
			if (hasFetch):
				return
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
				check_if_collide(delta)
				cache_facing_dir(direction)
				velocity = direction * (speed + 100)
				animated_sprite_2d.play_movement_animation(facing_direction)
				move_and_slide()
				if abs(player_hero.position.x - self.position.x) < 10.0 && abs(player_hero.position.y - self.position.y) < 10.0:
					velocity = Vector2.ZERO
					state = "wait"
					timer = idle_time
		"fetch":
			collision_shape.disabled = true
			var fetch_pos = position_to_fetch.global_position
			direction = (fetch_pos - self.position).normalized()
			cache_facing_dir(direction)
			velocity = direction * (speed + 1000)
			animated_sprite_2d.play_movement_animation(facing_direction)
			move_and_slide()
			if abs(fetch_pos.x - self.position.x) < 10.0 && abs(fetch_pos.y - self.position.y) < 10.0:
				velocity = Vector2.ZERO
				cache_facing_dir(direction)
				hasFetch = true
				state = "idle"
				collision_shape.disabled = false
		"wait":
			timer -= delta
			animated_sprite_2d.play_idle_animation(facing_direction)
			if timer <= 0:
				state = "follow"

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

func _on_item_used(value: ItemMemo) -> void:
	if value == item_to_fetch && doggo_translator.room == room_to_fetch:
		state = "fetch"
		

func check_if_collide(delta) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var normal = collision.get_normal()
		var slide_vector = velocity.slide(normal)
		velocity = slide_vector.normalized() * speed
