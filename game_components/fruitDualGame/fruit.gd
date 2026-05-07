extends CharacterBody2D

var direction_hit: String
var gravity = 300.0
var hit = false
var rotation_speed = 120.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func _process(delta):
	rotation_degrees += rotation_speed * delta


func _on_area_2d_side_area_entered(area: Area2D) -> void:
	if area.is_in_group("slash") and hit == false:
		hit = true
		$wholeSprite.visible = false
		$sliceRight.visible = true
		$sliceRight/half1.gravity = 100.0
		$sliceRight/half2.gravity = 100.0
		var fruit_speed = 1000
		$sliceRight/half1.velocity = Vector2.UP.rotated($sliceRight/half1.global_rotation) * fruit_speed
		$sliceRight/half2.velocity = Vector2.DOWN.rotated($sliceRight/half2.global_rotation) * fruit_speed
		$Timer.start()
		rotation_speed = 0
		$"..".score += 1


func _on_area_2_dm_middle_area_entered(area: Area2D) -> void:
	if area.is_in_group("slash") and hit == false:
		hit = true
		$wholeSprite.visible = false
		$sliceDown.visible = true
		$sliceDown/half1.gravity = 100.0
		$sliceDown/half2.gravity = 100.0
		var fruit_speed = 1000
		$sliceDown/half1.velocity = Vector2.LEFT.rotated($sliceDown/half1.global_rotation) * fruit_speed
		$sliceDown/half2.velocity = Vector2.RIGHT.rotated($sliceDown/half2.global_rotation) * fruit_speed
		$Timer.start()
		rotation_speed = 0
		$"..".score += 1



func _on_area_2_dm_right_s_area_entered(area: Area2D) -> void:
	if area.is_in_group("slash") and hit == false:
		hit = true
		$wholeSprite.visible = false
		$slicedRightSlashed.visible = true
		$slicedRightSlashed/half1.gravity = 100.0
		$slicedRightSlashed/half2.gravity = 100.0
		var fruit_speed = 1000
		$slicedRightSlashed/half1.velocity = Vector2.UP.rotated($slicedRightSlashed/half1.global_rotation + deg_to_rad(-45)) * fruit_speed
		$slicedRightSlashed/half2.velocity = Vector2.DOWN.rotated($slicedRightSlashed/half2.global_rotation + deg_to_rad(-45)) * fruit_speed
		$Timer.start()
		rotation_speed = 0
		$"..".score += 1


func _on_area_2_dm_left_s_area_entered(area: Area2D) -> void:
	if area.is_in_group("slash") and hit == false:
		hit = true
		$wholeSprite.visible = false
		$slicedLeftSlashed.visible = true
		$slicedLeftSlashed/half1.gravity = 100.0
		$slicedLeftSlashed/half2.gravity = 100.0
		var fruit_speed = 1000
		$slicedLeftSlashed/half1.velocity = Vector2.UP.rotated($slicedLeftSlashed/half1.global_rotation + deg_to_rad(45)) * fruit_speed
		$slicedLeftSlashed/half2.velocity = Vector2.DOWN.rotated($slicedLeftSlashed/half2.global_rotation + deg_to_rad(45)) * fruit_speed
		$Timer.start()
		rotation_speed = 0
		$"..".score += 1


func _on_timer_timeout() -> void:
	queue_free()
