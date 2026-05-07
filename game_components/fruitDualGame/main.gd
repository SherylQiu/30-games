extends Node2D

@onready var mouse_trail_line: Line2D = $Line2D

var max_trail_points = 5
var point_distance_threshold = 2.0
var mouse_still_timer = 0.0
var mouse_still_timout = 0.25
var last_mouse_pos: Vector2 = Vector2.INF

var game_is_on = false
var score = 0

func _ready():
	mouse_trail_line.clear_points()
	$LabelTime.text = "Time: 20"
	
func _process(delta):
	var current_mouse_pos = get_global_mouse_position()
	
	if game_is_on == true:
		$LabelTime.text = "Time: " + str(roundi($TimerGameLength.time_left))
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and game_is_on == true:
		$Area2DSlash/CollisionShape2D.disabled = false
		$Area2DSlash.global_position = get_global_mouse_position()
		
		if last_mouse_pos != Vector2.INF and current_mouse_pos.distance_to(last_mouse_pos) > 0.1:
			mouse_still_timer = 0.0
		else:
			mouse_still_timer += delta
			
		if mouse_trail_line.get_point_count() == 0 or \
		   mouse_trail_line.get_point_position(mouse_trail_line.get_point_count() - 1).distance_to(current_mouse_pos) > point_distance_threshold:
			mouse_trail_line.add_point(current_mouse_pos)
		
		while mouse_trail_line.get_point_count() > max_trail_points:
			mouse_trail_line.remove_point(0)
		
		if mouse_still_timer >= mouse_still_timout:
			mouse_trail_line.clear_points()
			mouse_still_timer = 0.0
			last_mouse_pos = Vector2.INF
	else:
		mouse_trail_line.clear_points()
		mouse_still_timer = 0.0
		last_mouse_pos = Vector2.INF
		$Area2DSlash/CollisionShape2D.disabled = true
	
	last_mouse_pos = current_mouse_pos
		

func _on_button_play_pressed():
	$"../StartScreen".visible = false
	game_is_on = true
	$TimerGameLength.start()


func _on_button_quit_pressed():
	get_tree().reload_current_scene()


func _on_timer_game_length_timeout():
	game_is_on = false
	$"../GameOverScreen".visible = true
	$"../GameOverScreen/Title".text = "Points: " + str(score)
