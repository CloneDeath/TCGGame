extends Node2D

var battlefield_scene := preload("res://Scenes/Battlefield.tscn")

func _ready():
    var battlefield = battlefield_scene.instantiate()
    add_child(battlefield)
