extends Control

#vars:
var resolucao : int
var is_fullscreaw : bool

func _on_resolucao_item_selected(index: int) -> void:
	resolucao = index

func _on_tela_cheia_toggled(toggled_on: bool) -> void:
	is_fullscreaw = toggled_on

func _on_aplicar_pressed() -> void:
	if is_fullscreaw:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	match resolucao:
		0:
			DisplayServer.window_set_size(Vector2i(1280,720))
		1:
			DisplayServer.window_set_size(Vector2i(1024,768))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 960))
		3: 
			DisplayServer.window_set_size(Vector2i(400, 300))
		4:
			DisplayServer.window_set_size(Vector2i(720, 1280))
