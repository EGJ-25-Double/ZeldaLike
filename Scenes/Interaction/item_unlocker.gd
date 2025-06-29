class_name ItemUnlocker
extends Node2D

@export var unlocked_item: ItemMemo
@export var area: Area2D
@export var sprite: Sprite2D

func _ready() -> void:
	sprite.texture = unlocked_item.sprite
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	if body is not PlayerHero: return
	InventoryUtils.unlock_item(unlocked_item)
	call_deferred("disable_process")
	hide()

func disable_process() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	
