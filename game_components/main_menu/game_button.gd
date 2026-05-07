extends TextureRect

@export var game_name: String
@export var game_number: String

#current games made
var starting_ui = preload("res://scenes/starting_ui.tscn")
var fruit_dual = preload("res://scenes/fruitDualGame.tscn")
var angle_tanks = preload("res://scenes/angelTanksGame.tscn")
var balls_game = preload("res://scenes/ballsGame.tscn")
var race_car_game = preload("res://scenes/raceCarGame.tscn")


func _ready():
	$LabelTitle.text = game_name
	$LabelNumber.text = "#" + game_number

func _on_button_play_pressed():
	var picked_game
	if game_name == "starting ui":
		picked_game = starting_ui.instantiate()
	if game_name == "Fruit Dual":
		picked_game = fruit_dual.instantiate()
	if game_name == "Angle Tanks":
		picked_game = angle_tanks.instantiate()
	if game_name == "Balls Game":
		picked_game = balls_game.instantiate()
	if game_name == "Race Cars":
		picked_game = race_car_game.instantiate()
	$"../../../../../..".add_child(picked_game)
	picked_game.global_position = Vector2(0,0)
	$"../../../..".visible = false
