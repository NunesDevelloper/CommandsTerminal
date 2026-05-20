extends Node

#script voltados para var internas
var is_url_scnes_old := "res://scenes/title_scream.tscn"

var is_fuslcream : bool = false
var resoluction : Vector3i = Vector3i(1152, 648, 15)

func save_config(data_config: Dictionary) -> void:
	var f = FileAccess.open("user://config.json", FileAccess.WRITE)
	var json = JSON.stringify(data_config)
	f.store_string(json)
	f.close()

func load_config():
	if not FileAccess.file_exists("user://config.json"): return null
	
	var f = FileAccess.open("user://config.json", FileAccess.READ)
	var data = f.get_as_text()
	
	var json = JSON.parse_string(data)
	
	if json == null: return null
	
	return json

func _ready() -> void:
	var dados = load_config()
	
	is_fuslcream = dados["is_fuslcream"]
	resoluction = Vector3(dados["resoluction"][0], dados["resoluction"][1], dados["resoluction"][2])
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_fuslcream else DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(resoluction.x, resoluction.y))
