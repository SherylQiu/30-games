extends Node2D

var oil = preload("res://game_components/raceCarGame/oil.tscn")

func _on_timer_oil_spill_timeout() -> void:
	if $"..".game_started == false:
		return
	
	var random = randi_range(1,5)
	var new_oil = oil.instantiate()
	add_child(new_oil)
	if random == 1:
		new_oil.global_position = $Oilspawn1.global_position
	if random == 2:
		new_oil.global_position = $Oilspawn2.global_position
	if random == 3:
		new_oil.global_position = $Oilspawn3.global_position
	if random == 4:
		new_oil.global_position = $Oilspawn4.global_position
	if random == 5:
		new_oil.global_position = $Oilspawn5.global_position
