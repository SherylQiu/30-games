extends Node2D

@export var spot_scene: PackedScene = null
@export var board_size: int = 0
@export var epot_cell_size: float = 64.0

@onready var bgRed: ColorRect = $bgRed
@onready var bgBlue: ColorRect = $bgBlue

enum PieceColor { NONE, RED, BLUE}
var _board_spots: Array = []
var _current_true: PieceColor = PieceColor.RED
var selected_spot: Vector2i = Vector2i(-1,-1)
var _must_jump: bool = false
var _con_milti_jump: bool = false
var _last_jump_spot: Vector2i = Vector2i(-1, -1)
