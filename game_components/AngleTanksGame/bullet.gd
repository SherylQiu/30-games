extends CharacterBody2D

@export var intial_speed: float = 100.0
@export var max_bounces: int = 3
@export var lifetime: float = 5.0

@onready var bullet_sprite: Sprite2D = $Sprite2D
@onready var bullet_hit_area: Area2D = $Area2D
@onready var lifetime_timer: Timer = $LifetimeTimer

var current_bounces: int = 0
const MAX_COLLISION_ITERATIONS = 4

func _ready():
	lifetime_timer.timeout.connect(_on_lifetime_timer_timout)
	lifetime_timer.wait_time = lifetime
	lifetime_timer.one_shot = true
	lifetime_timer.start()

func _on_lifetime_timer_timout():
	queue_free()

func _physics_process(delta):
	if velocity.length() > 0.1:
		rotation = velocity.angle()
		
	var motion = velocity * delta
	var interations = 0
	
	while interations < MAX_COLLISION_ITERATIONS:
		var collision = move_and_collide(motion)
		
		if collision:
			var collider = collision.get_collider()
			
			if (collider is TileMapLayer):
				
				if current_bounces < max_bounces:
					velocity = velocity.bounce(collision.get_normal())
					motion = velocity * collision.get_remainder().length() / velocity.length()
					current_bounces += 1
				else:
					queue_free()
					return
					
			elif collider.is_in_group("player") or collider.is_in_group("enemy_tank"):
				queue_free()
				return
			else:
				queue_free()
				return
		else:
			break
		interations += 1


func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		area.get_parent().queue_free()
		queue_free()
		return
	if area.is_in_group("player") or area.is_in_group("enemy_tank"):
		queue_free()
		return
