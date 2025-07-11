extends Node2D

var battlefield_scene := preload("res://Scenes/Battlefield.tscn")
const TurnTracker = preload("res://TurnTracker.gd")

var turn_tracker: TurnTracker

var player_resources := {
    "Wood": 0,
    "Gold": 0,
}

var opponent_resources := {
    "Wood": 0,
    "Gold": 0,
}

func _ready():
    var battlefield = battlefield_scene.instantiate()
    add_child(battlefield)
    update_resource_labels()

    turn_tracker = TurnTracker.new()
    add_child(turn_tracker)
    turn_tracker.connect("turn_changed", _on_turn_changed)
    _on_turn_changed(turn_tracker.current_player)

func _input(event):
    if event.is_action_pressed("ui_accept"):
        turn_tracker.next_turn()

func _on_turn_changed(player):
    print("Player %d's turn" % (player + 1))

func update_resource_labels():
    $PlayerResources/PlayerLabel.text = "Wood: %d | Gold: %d" % [
        player_resources["Wood"],
        player_resources["Gold"],
    ]
    $OpponentResources/OpponentLabel.text = "Wood: %d | Gold: %d" % [
        opponent_resources["Wood"],
        opponent_resources["Gold"],
    ]

func set_player_resources(wood: int, gold: int):
    player_resources["Wood"] = wood
    player_resources["Gold"] = gold
    update_resource_labels()

func set_opponent_resources(wood: int, gold: int):
    opponent_resources["Wood"] = wood
    opponent_resources["Gold"] = gold
    update_resource_labels()
