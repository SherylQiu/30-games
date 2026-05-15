extends CharacterBody2D

@export var max_speed: float = 300.0
@export var acceleration_rate: float = 100.0
@export var deceleration_rate: float = 150.0
@export var turn_speed: float = 3.0
@export var brake_deceleration: float = 400.0

@export var oil_slow_factor: float = 0.5
@export var oil_turn_factor: float = 0.5
@export var oil_effect_duration: float = 1.0

var current_speed: float = 0.0
var _sprite_node: Sprite2D
var is_oiled: bool = false

@onready var _player_detection_area: Area2D = $PlayerDetection
@onready var _oil_effect_timer: Timer = $OilEffectTimer

func _ready():
	_sprite_node = $Sprite2D
	if _oil_effect_timer:
		_oil_effect_timer.one_shot = true

func _physics_process(delta: float) -> void:
	if $"..".game_started == false:
		return
	
	var current_max_speed = max_speed * (oil_slow_factor if is_oiled else 1.0)
	var current_acceleration_rate = acceleration_rate * (oil_slow_factor if is_oiled else 1.0)
	var current_deceleration_rate = deceleration_rate
	var current_turn_speed = turn_speed * (oil_turn_factor if is_oiled else 1.0)
	
	var acceleration_input = Input.is_action_pressed("space_bar")
	var brake_input = Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right")
	
	if acceleration_input:
		current_speed += current_acceleration_rate * delta
		current_speed = min(current_speed, current_max_speed)
	elif  brake_input:
		current_speed = move_toward(current_speed, 0, brake_deceleration * delta)
	else:
		current_speed = move_toward(current_speed, 0, current_deceleration_rate * delta)
	
	var turn_direction: float = 0.0
	if Input.is_action_pressed("move_left"):
		turn_direction = -1.0
	elif Input.is_action_pressed("move_right"):
		turn_direction = 1.0
	
	if abs(current_speed) > 5:
		rotation += turn_direction * current_turn_speed * delta
	
	velocity = transform.x * current_speed
	
	move_and_slide()

func _on_player_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("lap"):
		$"..".blue_laps += 1
	if area.is_in_group("oil") and not is_oiled:
		is_oiled = true
		_oil_effect_timer.wait_time = oil_effect_duration
		_oil_effect_timer.start()


func _on_oil_effect_timer_timeout() -> void:
	is_oiled = false
