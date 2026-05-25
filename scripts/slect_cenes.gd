extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.is_url_scnes_old = self.scene_file_path
