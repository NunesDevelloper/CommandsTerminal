extends Control

@export_category("scenes_chanes")
@export var yellow_scens_chanes: String
@export var gream_scens_chanes: String

@onready var gream: Button = $gream

func _ready() -> void:
	for i in get_tree().root.get_children():
		if i.name == "config":
			self.remove_child(gream)

func _on_red_pressed() -> void: 
	get_tree().quit()

func _on_yellow_pressed() -> void:
	if not yellow_scens_chanes == "":
		get_tree().change_scene_to_file(yellow_scens_chanes)
		
	else: 
		for i in get_tree().root.get_children():
			if i.name == "config":
				get_tree().change_scene_to_file(Global.is_url_scnes_old)
		
		print("yellow_scnes")

func _on_gream_pressed() -> void:
	if not gream_scens_chanes == "":
		get_tree().change_scene_to_file(gream_scens_chanes)
	else:
		print("gream_scenes")
