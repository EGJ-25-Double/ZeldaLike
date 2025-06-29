@tool
class_name TrapTile
extends Area2D


enum Type { Green, Blue, Red, Cyan, Yellow, Magenta }


@export_category("Type")
@export var type: Type:
	set(value):
		type = value
		if !Engine.is_editor_hint(): return
		sprite.texture = data.traps[value].sprite


@export_category("Refs")
@export var data: TrapListMemo
@export var sprite: Sprite2D


func _ready() -> void:
	if Engine.is_editor_hint(): return
	sprite.texture = data.traps[type].sprite
