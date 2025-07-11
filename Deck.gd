extends Node2D

var cards = []
var hand
var deck_rect = Rect2(Vector2.ZERO, Vector2(80, 120))

func _ready():
    for i in range(1, 6):
        cards.append("Card %d" % i)
    update()

func _draw():
    draw_rect(deck_rect, Color(0, 0.5, 0))

func _input(event):
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        var pos = to_local(event.position)
        if deck_rect.has_point(pos):
            draw_card()

func draw_card():
    if cards.size() > 0 and hand:
        var card = cards.pop_back()
        hand.add_card(card)
        update()
