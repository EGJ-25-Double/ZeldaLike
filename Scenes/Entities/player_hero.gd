extends CharacterBody2D

class_name PlayerHero

@onready var animated_sprite_2d: CharacterAnimation = $AnimatedSprite2D
@onready var _shadow_sprite : Sprite2D      = $"FeedbackShadow/Sprite2D"

@export var feedback_pulse_time   := 0.15  # seconds for the little scale pulse 

const SPEED = 70000.0
static var instance: PlayerHero
var            _shadow_mat  : ShaderMaterial
var            _tween       : Tween

var interact_timer: float = 0

func _ready() -> void:
	instance = self
	
	_shadow_mat = _shadow_sprite.material as ShaderMaterial
	if _shadow_mat == null:
		push_error("FeedbackShadow/Sprite2D must carry a ShaderMaterial!")
		return
	_tween = create_tween()
	_shadow_mat.set_shader_parameter("is_ok", true)  

func _process(delta: float) -> void:
	if interact_timer > 0:
		interact_timer = interact_timer - delta

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
		if interact_timer <= .08:
			animated_sprite_2d.play_movement_animation(PlayerUtils.player_dir)
		move_and_slide()
	elif interact_timer <= 0:
		animated_sprite_2d.play_idle_animation(PlayerUtils.player_dir)

func start_interact_anim() -> void:
	interact_timer = .3
	animated_sprite_2d.play_interact_animation(PlayerUtils.player_dir)

func cache_player_dir() -> void:
	if velocity.y > 0:
		PlayerUtils.player_dir = Direction.Down
	elif velocity.y < 0:
		PlayerUtils.player_dir = Direction.Up
	elif velocity.x > 0:
		PlayerUtils.player_dir = Direction.Right
	elif velocity.x < 0:
		PlayerUtils.player_dir = Direction.Left


func show_interaction_feedback(success: bool) -> void:
	if _shadow_mat == null:
		return

	# set shader colour
	_shadow_mat.set_shader_parameter("is_ok", success)
	# show 
	_shadow_sprite.modulate.a = 1
	_shadow_sprite.show() 

	# squash‑and‑stretch pulse so it ‘pops’
	_tween.kill()
	_tween = create_tween()
	# scale up for pulse
	_tween.tween_property(_shadow_sprite, "scale",
	Vector2(1.10, 1.10), feedback_pulse_time * 0.5).set_trans(Tween.TRANS_SINE)

	_tween.tween_property(_shadow_sprite, "scale",
	Vector2(0.90, 0.90), feedback_pulse_time * 0.5).set_trans(Tween.TRANS_SINE)
	#fade out
	_tween.tween_property(_shadow_sprite, "modulate:a", 0.0, 0.1)
	# hide
	_tween.tween_callback(func():
		_shadow_sprite.hide()
	)

static func _on_interaction_success() -> void:
	instance.show_interaction_feedback(true)

static func _on_interaction_fail() -> void:
	instance.show_interaction_feedback(false)
	
