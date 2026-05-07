extends CharacterBody2D

@export var move_speed: float = 800.0
@export var fixed_y_position: float = 580.0
@export var dead_zone_width: float = 20.0

func _ready() -> void:
	global_position = Vector2(global_position.x, fixed_y_position)
	
func _physics_process(delta):
	if $"..".game_started == false:
		return
		
	var mouse_x = get_global_mouse_position().x
	var player_x = global_position.x
		
	var direction_x = 0.0
		
	var dead_zone_left = player_x - (dead_zone_width / 2.0)
	var dead_zone_right = player_x + (dead_zone_width / 2.0)
		
	if mouse_x < dead_zone_left:
		direction_x = -1.0
	elif mouse_x > dead_zone_right:
		direction_x = 1.0
		
	velocity.x = direction_x * move_speed
	velocity.y = 0
	move_and_slide()
	global_position = Vector2(global_position.x, fixed_y_position)
