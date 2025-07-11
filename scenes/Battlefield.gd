extends Node2D

@export var grid_size: Vector2i = Vector2i(7, 7)
@export var cell_size: Vector2 = Vector2(64, 64)

func _ready():
    _center_grid()
    queue_redraw()
    get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))

func _on_viewport_size_changed():
    _center_grid()
    queue_redraw()

func _center_grid():
    var viewport_size = get_viewport_rect().size
    var grid_px_size = Vector2(grid_size) * cell_size
    position = viewport_size / 2 - grid_px_size / 2

func _draw():
    var width = grid_size.x
    var height = grid_size.y
    var w = width * cell_size.x
    var h = height * cell_size.y
    var color = Color(1, 1, 1)
    for x in range(width + 1):
        var start = Vector2(x * cell_size.x, 0)
        var end = Vector2(x * cell_size.x, h)
        draw_line(start, end, color)
    for y in range(height + 1):
        var start = Vector2(0, y * cell_size.y)
        var end = Vector2(w, y * cell_size.y)
        draw_line(start, end, color)
