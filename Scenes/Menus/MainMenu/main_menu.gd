extends Control
@onready var sound_hover_player = $ButtonHover
@onready var sound_clic_player = $ButtonPress
@onready var sound_startgame_player = $StartGame

func _ready():
	$VBoxContainer/PlayBtn.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/testmap_hero.tscn")


func _on_help_btn_pressed() -> void:
	$HelpUI.visible = true
	$HelpUI/HelpBackBtn.grab_focus()


func _on_credits_btn_pressed() -> void:
	$CreditsUI.visible = true
	$CreditsUI/CreditsBackBtn.grab_focus()


func _on_quit_btn_pressed() -> void:
	get_tree().quit()


func _on_help_back_btn_pressed() -> void:
	$HelpUI.visible = false
	$VBoxContainer/PlayBtn.grab_focus()


func _on_credits_back_btn_pressed() -> void:
	$CreditsUI.visible = false
	$VBoxContainer/PlayBtn.grab_focus()
