extends CharacterBody2D

@export var tank_speed: float = 100.0
@export var tank_turn_speed: float = 2.5
@export var turret_rotation_speed: float = 10.0
@export var bullet_speed: float = 400.0
@export var fire_rate: float = 0.5
@export var max_health: int = 3

@export var bullet_scene: PackedScene

@onready var tank_body_sprite: Node2D = $body
@onready var tank_turret_sprite: Node2D = $turret
@onready var bullet_spawn_point: Node2D = $turret/bulletSpawnPoint
@onready var tank_hit_area: Area2D = $Area2D
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var movement_timer: Timer = $MovementTimer

var current_health: int = 3
var can_fire: bool = true

enum AIMovementState {
	IDLE,
	MOVE_FORWARD,
	MOVE_BACKWARD,
	TURN_LEFT,
	TURN_RIGHT
}

var current_ai_movement_state: AIMovementState = AIMovementState.IDLE
var current_ai_movement_duration: float = 0.0

var target_turret_angle: float = 0.0

func _ready():
	current_health = max_health
	fire_rate_timer.wait_time = randf_range(1.0, 3.0)
	fire_rate_timer.one_shot = true
	fire_rate_timer.start()
	movement_timer.one_shot = true
	_on_movement_timer_timeout()

func _process(delta):
	if $"..".game_started == false:
		return
	_aim_turret_randomly(delta)
	
	if can_fire == true and fire_rate_timer.is_stopped():
		_shoot()
		can_fire = false
		fire_rate_timer.wait_time = randf_range(1.0, 3.0)
		fire_rate_timer.start()
		
func _physics_process(delta):
	if $"..".game_started == false:
		return
	
	var movement_direction: float = 0.0
	var tank_turn_direction: float = 0.0
	
	match current_ai_movement_state:
		AIMovementState.MOVE_FORWARD:
			movement_direction = 1.0
		AIMovementState.MOVE_BACKWARD:
			movement_direction = -1.0
		AIMovementState.TURN_LEFT:
			tank_turn_direction = -1.0
		AIMovementState.TURN_RIGHT:
			tank_turn_direction = 1.0
		AIMovementState.IDLE:
			pass
	
	velocity = transform.x * movement_direction * tank_speed
	move_and_slide()
	rotation += tank_turn_direction * tank_turn_speed * delta
		
func _aim_turret_randomly(delta: float) -> void:
	if abs(fmod(tank_turret_sprite.global_rotation - target_turret_angle + PI, 2 * PI) - PI) < deg_to_rad(5):
		target_turret_angle = randf_range(0, 2 * PI)
		
	tank_turret_sprite.global_rotation = lerp_angle(
		tank_turret_sprite.global_rotation,
		target_turret_angle,
		turret_rotation_speed * delta
	)
		
func _shoot() -> void:
	var bullet_instance = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = bullet_spawn_point.global_position
	bullet_instance.velocity = tank_turret_sprite.global_transform.x * bullet_speed


func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		$"..".red_tanks -= 1
		current_health -= 1
		if current_health <= 0:
			queue_free()
	
func _on_fire_rate_timer_timeout():
	can_fire = true


func _on_movement_timer_timeout():
	var random_action_choice = randi_range(0, 4)
	var random_duration = randf_range(0.5, 2.0)
	
	current_ai_movement_state = random_action_choice
	current_ai_movement_duration = random_duration
	
	movement_timer.wait_time = current_ai_movement_duration
	movement_timer.start()
