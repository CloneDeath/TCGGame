extends Node2D

var cards = []

func add_card(card):
    cards.append(card)
    var label = Label.new()
    label.text = str(card)
    label.position = Vector2(100 * (cards.size() - 1), 0)
    add_child(label)
