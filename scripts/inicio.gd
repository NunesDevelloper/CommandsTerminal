extends Button

@onready var point: TextureRect = $point

var is_select := false

func _ready() -> void:
	connect("button_down", a)

func a() -> void:
	if is_select == true:
		self.add_theme_color_override("font_color", "#ffffff") 
		is_select = false
	else:
		self.add_theme_color_override("font_color", "#00ff00")
		is_select = true
	
