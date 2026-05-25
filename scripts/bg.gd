extends Control

@onready var nameLabel: Label = $Control/name

func _process(_delta: float) -> void:
	var path_pai = get_parent().scene_file_path
	path_pai = path_pai.replace(".tscn", "") 
	path_pai = path_pai.replace("res://", "/")
	nameLabel.text = path_pai

	
