extends Control


func _ready():
	$Button.grab_focus()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/MainMenu/main_menu.tscn")
