extends Camera2D

var dragging := false

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
        if event.pressed:
            dragging = true
        else:
            dragging = false
    elif event is InputEventMouseMotion and dragging:
        position -= event.relative

