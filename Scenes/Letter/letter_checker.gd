class_name LetterChecker
extends Control


@export var letters: Array[LetterSetter]


var done: bool


func _ready() -> void:
	visible = false
	for letter in letters:
		letter.correct_set.connect(_on_correct_set)


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
