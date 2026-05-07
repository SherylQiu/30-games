extends CharacterBody2D

@export var initial_speed: float = 400.0
@export var bounce_strength:  float = 1.0

var rng = RandomNumberGenerator.new()
var current_velocity: Vector2

func _ready() -> void:
	rng.randomize()
	set_random_initial_velocity()
	
func _physics_process(delta):
	if $"..".game_started == false:
		return
	
	velocity = current_velocity
	
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		var normal = collision_info.get_normal()
		current_velocity = current_velocity.bounce(normal) * bounce_strength
		global_position += normal * 2
		
	if current_velocity.length_squared() > 0.01:
		current_velocity = current_velocity.normalized() * initial_speed
		
func set_random_initial_velocity():
	var angle_degrees = rng.randf_range(45, 135)
	if rng.randi() % 2 == 0:
		angle_degrees += 180
	var initial_direction = Vector2.RIGHT.rotated(deg_to_rad(angle_degrees))
	current_velocity = initial_direction * initial_speed
	
