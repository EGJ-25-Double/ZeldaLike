class_name LetterChecker
extends Control


@export var letters: Array[LetterSetter]


@onready var win_area: Area2D = $"Win Area"


var done: bool


func _ready() -> void:
	visible = false
	for letter in letters:
		letter.correct_set.connect(_on_correct_set)
	win_area.body_entered.connect(_on_win_area_entered)


func _on_win_area_entered(body) -> void:
	if !done: return
	if InventoryUtils.item_a != null || InventoryUtils.item_b != null: return
	get_tree().change_scene_to_file("res://Scenes/Menus/victory_screen.tscn")


func _on_correct_set(value: bool) -> void:
	if done: return
	if !value: return
	if !_check_letters(): return
	done = true
	visible = true
	var tween = get_tree().create_tween()
	modulate = Color.TRANSPARENT
	tween.tween_property(self, "modulate", Color.WHITE, .5)
	tween.play()


func _check_letters() -> bool:
	for letter in letters:
		if !letter.is_correct: return false
	return true
