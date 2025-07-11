extends Node
class_name TurnTracker

signal turn_changed(current_player: int)

@export var num_players: int = 2
var current_player: int = 0

func _ready():
    emit_signal("turn_changed", current_player)

func next_turn():
    current_player = (current_player + 1) % num_players
    emit_signal("turn_changed", current_player)
