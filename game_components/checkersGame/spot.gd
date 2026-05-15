extends ColorRect

signal  spot_selected(row, col)

@export var row: int = 0
@export var col: int = 0

@onready var red_piece_sprite: Sprite2D = $opponent
@onready var blue_piece_sprite: Sprite2D = $player
@onready var red_crown_sprite: Sprite2D = $opponent/crown2
@onready var blue_crown_sprite: Sprite2D = $player/crown
@onready var click_button: Button = $Button

enum PieceColor { NONE, RED, BLUE }
var current_piece_color: PieceColor = PieceColor.NONE
var is_king: bool = false

func _ready() -> void:
	_hide_all_pieces_and_crowns()
	click_button.pressed.connect(_on_button_pressed)
	
func set_piece(color: PieceColor, king: bool = false) -> void:
	_hide_all_pieces_and_crowns()
	current_piece_color = color
	is_king = king
	match current_piece_color:
		PieceColor.RED:
			red_piece_sprite.visible = true
			red_crown_sprite.visible = is_king
		PieceColor.BLUE:
			blue_piece_sprite.visible = true
			blue_crown_sprite.visible = is_king
		PieceColor.NONE:
			pass

func clear_piece():
	_hide_all_pieces_and_crowns()
	current_piece_color = PieceColor.NONE
	is_king = false
	
func get_piece_color() -> PieceColor:
	return current_piece_color

func has_piece() -> bool:
	return current_piece_color != PieceColor.NONE

func is_piece_king() -> bool:
	return is_king

func _hide_all_pieces_and_crowns() -> void:
	red_piece_sprite.visible = false
	blue_piece_sprite.visible = false
	red_crown_sprite.visible = false
	blue_crown_sprite.visible = false
	

func _on_button_pressed() -> void:
	emit_signal("spot_selected", row, col)
