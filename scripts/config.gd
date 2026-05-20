extends Control

var is_fuslcream : bool = Global.is_fuslcream
var resoluction : Vector3i = Global.resoluction

@onready var slect_resolution: OptionButton = $video/slect_resolution
@onready var is_fuscream_button: CheckButton = $video/is_fullsecream

func _ready() -> void:
	var dados = Global.load_config()
	
	if dados == null: return 
	
	is_fuslcream = dados["is_fuslcream"]
	resoluction = Vector3(dados["resoluction"][0], dados["resoluction"][1], dados["resoluction"][2])
	
	is_fuscream_button.button_pressed = is_fuslcream
	slect_resolution.select(resoluction.z)
	apply()

func apply() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_fuslcream else DisplayServer.WINDOW_MODE_WINDOWED)
	DisplayServer.window_set_size(Vector2i(resoluction.x, resoluction.y))
	Global.is_fuslcream = is_fuslcream
	Global.resoluction = resoluction
	var data = {
		"is_fuslcream" = is_fuslcream,
		"resoluction" = [resoluction.x, resoluction.y, resoluction.z]
	}
	
	Global.save_config(data)

func reset() -> void:
	
	is_fuslcream = false
	resoluction = Vector3i(1152, 648, 0)
	apply()

func _on_is_fullsecream_toggled(toggled_on: bool) -> void: is_fuslcream = toggled_on

func _on_slect_resolution_item_selected(index: int) -> void:
	var intens: String = slect_resolution.get_item_text(index)
	var parts: PackedStringArray = intens.split(" X ")
	resoluction = Vector3i(parts[0].to_int(), parts[1].to_int(), index)
