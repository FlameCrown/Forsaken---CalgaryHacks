extends Node2D

@export var scene_to_instantiate: PackedScene

func _ready():
  var new_scene = scene_to_instantiate.instantiate()
  add_child(new_scene)
  
