extends Node2D

@export var grid_size: Vector2i = Vector2i(7, 7)
@export var cell_size: Vector2 = Vector2(64, 64)

var tile_scenes := {
    "Forest": preload("res://Scenes/Tiles/Forest.tscn"),
    "River": preload("res://Scenes/Tiles/River.tscn"),
    "Village": preload("res://Scenes/Tiles/Village.tscn"),
}

var tiles: Array = []
var selected_cell: Vector2i = Vector2i(-1, -1)

@onready var build_menu := $BuildMenu

func _ready():
    queue_redraw()
    tiles.resize(grid_size.y)
    for y in range(grid_size.y):
        tiles[y] = []
        tiles[y].resize(grid_size.x)
    for name in tile_scenes.keys():
        build_menu.add_item(name)
    build_menu.connect("id_pressed", _on_build_menu_id_pressed)

    # Center the battlefield within the viewport
    var viewport_size = get_viewport_rect().size
    var grid_pixel_size = Vector2(grid_size) * cell_size
    position = (viewport_size - grid_pixel_size) / 2

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

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        var pos = to_local(event.position)
        var cell = Vector2i(int(pos.x / cell_size.x), int(pos.y / cell_size.y))
        if cell.x < 0 or cell.y < 0 or cell.x >= grid_size.x or cell.y >= grid_size.y:
            return
        if tiles[cell.y][cell.x] == null:
            selected_cell = cell
            build_menu.position = pos
            build_menu.popup()

func _on_build_menu_id_pressed(id):
    var name = build_menu.get_item_text(id)
    if not tile_scenes.has(name):
        return
    var scene = tile_scenes[name]
    var tile = scene.instantiate()
    add_child(tile)
    tile.position = Vector2(selected_cell.x, selected_cell.y) * cell_size
    tiles[selected_cell.y][selected_cell.x] = tile
