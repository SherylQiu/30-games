extends Node2D

var small_boards = []
var main_board_status = []
var current_player = "X"
var next_small_board = null
var game_started = false

func _ready() -> void:
	initialize_board()
	update_area_makers()
	
func initialize_board():
	small_boards = []
	for a in range(3):
		var row = []
		for b in range(3):
			var sb = []
			for i in range(3):
				sb.append(["", "", ""])
			row.append(sb)
		small_boards.append(row)
	
	main_board_status = []
	for i in range(3):
		main_board_status.append(["", "", ""])
		
	current_player = "X"
	next_small_board = null

func check_winner(board):
	for i in range(3):
		if board[i][0] != "" and board[i][0] == board[i][1] and board[i][1] == board[i][2]:
			return board[i][0]
		
	for j in range(3):
		if board[0][j] != "" and board[0][j] == board[1][j] and board[1][j] == board[2][j]:
			return board[0][j]
		
	if board[0][0] != "" and board[0][0] == board[1][1] and board[1][1] == board[2][2]:
		return board[0][0]
	if board[0][2] != "" and board[0][2] == board[1][1] and board[1][1] == board[2][0]:
		return board[0][2]
	
	var full = true
	for i in range(3):
		for j in range(3):
			if board[i][j] == "":
				full = false
				break
		if not full:
			break
	if full:
		return "draw"
	return ""
		
func is_full(board):
	for i in range(3):
		for j in range(3):
			if board[i][j] == "":
				return false
	return true

func get_available_small_board():
	if next_small_board != null:
		var p = int(next_small_board.x)
		var q = int(next_small_board.y)
		if main_board_status[p][q] == "" and not is_full(small_boards[p][q]):
			return [Vector2(p,q)]
	
	var available = []
	for p in range(3):
		for q in range(3):
			if main_board_status[p][q] == "" and not is_full(small_boards[p][q]):
				available.append(Vector2(p,q))
	return available
	
func make_move(a, b, i, j):
	var available = get_available_small_board()
	if not Vector2(a,b) in available:
		return
		
	var board = small_boards[a][b]
	if board[i][j] != "":
		return
		
	board[i][j] = current_player
		
	var winner = check_winner(board)
	if winner != "" and winner != "draw":
		main_board_status[a][b] = winner
		
		var main_winner = check_winner(main_board_status)
		if main_winner != "" and main_winner != "draw":
			$GameOverScreen.visible = true
			if current_player == "X":
				$GameOverScreen/title.text = "O wins! \n(人*´∀｀)+':｡+ﾟ"
			if current_player == "O":
				$GameOverScreen/title.text = "X wins! \n(人*´∀｀)+':｡+ﾟ"
			return "Game over"
	next_small_board = Vector2(i, j)
	update_area_makers()
	
	current_player = "O" if current_player == "X" else "X"
	
	var next_available = get_available_small_board()
	if next_available.is_empty():
		$GameOverScreen.visible = true
		$GameOverScreen/title.text = "Tie\n( ´▽｀)"
		return
	return "Move made"
		
func update_area_makers():
	for child in $AreaMark.get_children():
		child.visible = false
	
	var available = get_available_small_board()
	
	for pos in available:
		var index = int(pos.x * 3 + pos.y + 1)
		$AreaMark.get_node("AreaMark" + str(index)).visible = true

func _on_button_exit_pressed() -> void:
	get_tree().reload_current_scene()


func _on_button_play_pressed() -> void:
	game_started = true
	$StartScreen.visible = false
