extends Node2D

var game_started = false
var blue_laps = 0
var red_laps = 0

func game_over():
	$GameOverScreen.visible = true
	game_started = false

func _process(delta: float) -> void:
	if blue_laps >= 3:
		$GameOverScreen/title.text = "Blue Wins!\n⁽⁽٩(๑˃ ᗨ ˂)۶⁾⁾"
		game_over()
	elif  red_laps >= 3:
		$GameOverScreen/title.text = "Red Wins!\n( ´•ω•` )"
		game_over()

func _on_button_exit_pressed() -> void:
	get_tree().reload_current_scene()


func _on_button_play_pressed() -> void:
	game_started = true
	$StartScreen.visible = false
