extends Node2D

var battlefield_scene := preload("res://Scenes/Battlefield.tscn")
const TurnTracker = preload("res://TurnTracker.gd")

var turn_tracker: TurnTracker

func _ready():
	var battlefield = battlefield_scene.instantiate()
	add_child(battlefield)

	turn_tracker = TurnTracker.new()
	add_child(turn_tracker)
	turn_tracker.connect("turn_changed", _on_turn_changed)
	_on_turn_changed(turn_tracker.current_player)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		turn_tracker.next_turn()

func _on_turn_changed(player):
	print("Player %d's turn" % (player + 1))
