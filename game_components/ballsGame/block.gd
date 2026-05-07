extends Node2D

@export var health = 3

func _process(delta):
	if health <= 0:
		$"../..".score += 1
		queue_free()
	elif health == 2:
		$ColorRect.color = Color("#dd9b4b")
	elif health == 1:
		$ColorRect.color = Color("#e9d4af")
	elif  health == 3:
		$ColorRect.color = Color("#a74713")
	$Label.text = str(health)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ball"):
		health -= 1
