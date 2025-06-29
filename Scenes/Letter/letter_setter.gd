class_name LetterSetter
extends Area2D


@export_category("Memo")
@export var items: ItemListMemo
@export var right_item: ItemMemo

@export_category("Screen")
@export var screen_off: Texture2D
@export var screen_on: Texture2D

@export_category("Trigger")
@export var trigger_off: Texture2D
@export var trigger_on: Texture2D


@onready var label: Label = $"Label"
@onready var sprite_screen: Sprite2D = $"Sprite Screen"
@onready var sprite_trigger: Sprite2D = $"Sprite Trigger"


var is_triggered: bool:
	set(value):
		is_triggered = value
		_set_sprites(value)

var is_correct: bool:
	set(value):
		if is_correct == value: return
		is_correct = value
		correct_set.emit(value)


signal correct_set(value: bool)


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	InventoryUtils.subscribe_to_item_used(_on_item_used)
	_set_sprites(false)


func _exit_tree() -> void:
	InventoryUtils.unsubscribe_from_item_used(_on_item_used)


func _on_body_entered() -> void:
	is_triggered = true


func _on_body_exited() -> void:
	is_triggered = false


func _set_sprites(value: bool) -> void:
	if value:
		sprite_screen.texture = screen_on
		sprite_trigger.texture = trigger_on
	else:
		sprite_screen.texture = screen_off
		sprite_trigger.texture = trigger_off


func _on_item_used(value: ItemMemo) -> void:
	if value == null: return
	if !is_triggered: return
	label.text = value.letter
	is_correct = value == right_item
