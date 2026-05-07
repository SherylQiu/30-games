extends CharacterBody2D

var direction_hit: String
var gravity = 300.0

func _ready():
	$wholeSprite/AnimationPlayer.play("RESET")

func _process(delta):
	rotation_degrees += 120 * delta

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("slash"):
		$"../AnimationPlayer".play("boom")
		$"..".score -= 5
		queue_free()
