extends Node2D

var apple = preload("res://game_components/fruitDualGame/apple.tscn")
var banana = preload("res://game_components/fruitDualGame/banana.tscn")
var grape = preload("res://game_components/fruitDualGame/grape.tscn")
var watermelon = preload("res://game_components/fruitDualGame/watermelon.tscn")
var cherry = preload("res://game_components/fruitDualGame/cherry.tscn")

func _on_timer_timeout():
	if $"..".game_is_on == false:
		return
	var ran = randi_range(1,7)
	var cherry_chance = randi_range(1,10)
	var fruit_instance
	
	if cherry_chance <= 2:
		fruit_instance = cherry.instantiate()
	else:
		var fruit = randi_range(1,4)
		if fruit == 1:
			fruit_instance = apple.instantiate()
		elif fruit == 2:
			fruit_instance = banana.instantiate()
		elif fruit == 3:
			fruit_instance = grape.instantiate()
		elif fruit == 4:
			fruit_instance = watermelon.instantiate()
	
	add_sibling(fruit_instance)
	var fruit_speed = 600
	if ran == 1:
		fruit_instance.global_position = $connon1.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation + deg_to_rad(20)) * fruit_speed
	elif ran == 2:
		fruit_instance.global_position = $connon2.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation) * fruit_speed
	elif ran == 3:
		fruit_instance.global_position = $connon3.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation) * fruit_speed
	elif ran == 4:
		fruit_instance.global_position = $connon4.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation) * fruit_speed
	elif ran == 5:
		fruit_instance.global_position = $connon5.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation + deg_to_rad(-20)) * fruit_speed
	elif ran == 6:
		fruit_instance.global_position = $connon6.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation + deg_to_rad(-80)) * fruit_speed
	elif ran == 7:
		fruit_instance.global_position = $connon7.global_position
		fruit_instance.velocity = Vector2.UP.rotated(fruit_instance.global_rotation + deg_to_rad(80)) * fruit_speed
	
