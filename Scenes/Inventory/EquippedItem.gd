class_name EquippedItem
extends Control

@export var ref: InventoryItem
@export var label: Label
@export var text: String

func _ready() -> void:
	label.text = text
