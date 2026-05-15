extends Node2D

func game_over(who_wins: String):
	$GameOverScreen.visible = true
	if who_wins == "Red":
		$GameOverScreen/title.text = "Red wins!"
	if who_wins == "Blue":
		$GameOverScreen/title.text = "blue wins!"

func _on_button_exit_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_play_pressed() -> void:
	$StartScreen.visible = false
