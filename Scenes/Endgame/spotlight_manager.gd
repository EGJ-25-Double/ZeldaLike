extends InteractionEnabler
class_name SpotlightManager

@export var bot_sprite: Sprite2D
@export var top_sprite: Sprite2D
@export var collision_transform: Node2D

var timer: float = 0
# 0 is waiting for player, 1 is active, 2 is resolved
var state: int = 0

func _process(delta: float) -> void:
	if state == 1:
		timer = timer + delta;
		if timer > 11:
			timer = 0
	
	bot_sprite.visible = state == 1
	top_sprite.visible = state == 1 && timer > 1

func _internal_interact() -> void:
	if state == 1 && timer > 1:
		state = 2
		super._internal_interact()
		print("Finished spotlight event")
	
func start_state() -> void:
	if state == 0:
		state = 1
		print("Started spotlight event")
