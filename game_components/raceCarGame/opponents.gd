extends CharacterBody2D

@export var base_speed:float = 250.0
@export var rotation_smothness: float = 5.0

@export var oil_slow_factor: float = 0.5
@export var oil_effect_duation: float = 1.0

var path_follow_parent: PathFollow2D = null
var is_oiled: bool = false

@onready var _player_detection_area: Area2D = $PlayerDetection
@onready var _oil_effect_timer: Timer = $OilEffectTimer

func _ready():
	if get_parent() is PathFollow2D:
		path_follow_parent = get_parent()
		
	if _oil_effect_timer:
		_oil_effect_timer.one_shot = true
		_oil_effect_timer.wait_time = oil_effect_duation
		
func _process(delta):
	if $"../../..".game_started == false:
		return
	
	var current_effected_speed = base_speed * (oil_slow_factor if is_oiled else 1.0)
	path_follow_parent.progress += current_effected_speed * delta
	var target_global_rotation = path_follow_parent.global_rotation
	global_rotation = lerp_angle(global_rotation, target_global_rotation, rotation_smothness * delta)
	

func _on_player_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("lap"):
		$"../../..".red_laps += 1
	if area.is_in_group("oil") and not is_oiled:
		is_oiled = true
		_oil_effect_timer.start()
		
func _on_oil_effect_timer_timeout() -> void:
	is_oiled = false
