extends Control

var is_click := false

func _ready() -> void:
	self.visible = false
	$"../info_button".connect("button_down", show_info_box)
	

func show_info_box() -> void:
	if is_click == false:
		is_click = true
		self.visible = true
	else:
		is_click = false
		self.visible = false
