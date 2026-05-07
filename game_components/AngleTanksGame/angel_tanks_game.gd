extends Node2D

var game_started = false
var blue_tanks = 1
var red_tanks = 3

func _process(delta):
	if red_tanks <= 0:
		game_over()

func game_over():
	if blue_tanks <= 0:
		$GameOverScreen/title.text = "Red Wins!"
	if blue_tanks <= 0:
		$GameOverScreen/title.text = "Blue Wins!"
	$GameOverScreen.visible = true
	game_started = false

func _on_button_exit_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_play_pressed() -> void:
	game_started = true
	$StartScreen.visible = false
