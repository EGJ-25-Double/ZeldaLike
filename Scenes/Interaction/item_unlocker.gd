class_name ItemUnlocker
extends Node2D

@export var unlocked_item: ItemMemo
@export var area: Area2D
@export var sprite: Sprite2D

var done: bool

func _ready() -> void:
	sprite.texture = unlocked_item.sprite
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	if body is not PlayerHero: return
	if done: return
	done = true
	InventoryUtils.unlock_item(unlocked_item)
	hide()
