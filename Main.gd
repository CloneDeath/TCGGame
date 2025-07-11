extends Node2D

var deck
var hand

func _ready():
    hand = Hand.new()
    add_child(hand)
    hand.position = Vector2(200, 300)

    deck = Deck.new()
    add_child(deck)
    deck.position = Vector2(100, 100)
    deck.hand = hand
