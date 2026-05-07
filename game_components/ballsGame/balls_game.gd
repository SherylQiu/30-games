extends Node2D

var game_started = false
var score = 0

func game_over():
	game_started = false
	$GameOverScreen.visible = true
	$GameOverScreen/title.text = "Points = " + str(score)

func _on_button_exit_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_play_pressed() -> void:
	$StartScreen.visible = false
	game_started = true

func _on_area_2d_game_over_area_entered(area: Area2D) -> void:
	game_over()
