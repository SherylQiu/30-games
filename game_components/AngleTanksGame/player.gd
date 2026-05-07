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

var current_health: int = 3
var can_fire: bool = true

func _ready():
	current_health = max_health
	fire_rate_timer.wait_time = fire_rate
	fire_rate_timer.one_shot = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _process(delta):
	if $"..".game_started == false:
		return
	_aim_turret_at_mouse(delta)
	
	if Input.is_action_just_pressed("space_bar") and can_fire == true:
		_shoot()
		can_fire = false
		fire_rate_timer.start()

func _physics_process(delta):
	if $"..".game_started == false:
		return
		
	var movement_direction: float = 0.0
	if Input.is_action_pressed("move_up"):
		movement_direction = 1.0
	if Input.is_action_pressed("move_down"):
		movement_direction = -1.0
	
	velocity = transform.x * movement_direction * tank_speed
	
	move_and_slide()
	
	var tank_turn_direction: float = 0.0
	if Input.is_action_pressed("move_left"):
		tank_turn_direction = -1.0
	if Input.is_action_pressed("move_right"):
		tank_turn_direction = 1.0
	
	rotation += tank_turn_direction * tank_turn_speed * delta
	
func _aim_turret_at_mouse(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - tank_turret_sprite.global_position).normalized()
	var target_angle = tank_turret_sprite.global_position.angle_to_point(mouse_pos)
	
	tank_turret_sprite.global_rotation = lerp_angle(tank_turret_sprite.global_rotation, target_angle, turret_rotation_speed * delta)
	
func _shoot() -> void:
	var bullet_instance = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = bullet_spawn_point.global_position
	bullet_instance.velocity = tank_turret_sprite.global_transform.x * bullet_speed
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		$"..".blue_tanks -= 1
		$"..".game_over()
		queue_free()

func _on_fire_rate_timer_timeout():
	can_fire = true
