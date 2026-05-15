extends Button

@export var board_row: int
@export var board_column: int
@export var spot_row: int
@export var spot_column: int


func _on_pressed() -> void:
	if $"../../..".game_started == false:
		return
		
	var action = $"../../..".make_move(board_row, board_column, spot_row, spot_column)
	if action == "Move made":
		if $"../../..".current_player == "X":
			$shapeX.visible = true
		else:
			$shapeO.visible = true
