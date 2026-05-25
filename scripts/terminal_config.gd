extends Control

@onready var button_ligth_rigth: Control = $"../button_ligth_rigth"
@onready var red: Button = $button_ligth_termianlminal/red
@onready var yellow: Button = $button_ligth_termianlminal/yellow
@onready var input: LineEdit = $input
@onready var historic: RichTextLabel = $historic
@onready var slect_resolution: OptionButton = $"../video/slect_resolution"
@onready var is_fullsecream: CheckButton = $"../video/is_fullsecream"
@onready var config: Control = $".."

func _ready() -> void:
	red.connect("button_down", button_ligth_rigth._on_red_pressed)
	yellow.connect("button_down", button_ligth_rigth._on_yellow_pressed)

var commands = {
	"clear": clear, "cls":clear,
	"echo": echo,
	"help":help,
	"exit":exit,
	"resolution":resolution,
	"fullscreen":fullscreen,
	"reste":reste,
	"apply":apply,
	"show_config":show_config
}

func _on_input_text_submitted(new_text: String) -> void:
	new_text = new_text.strip_edges()
	if new_text == "":
		historic.append_text("> \n")
		return
		
	historic.append_text("> " + new_text + "\n") 
	input.clear()    
	
	var parts = new_text.split(" ")
	var command_name = parts[0].to_lower()
	var args = parts.slice(1)
	
	if commands.has(command_name):
		commands[command_name].call(args)
	else:
		historic.append_text("[color=red] Unknown command. [/color]  \n")

func exit(_args: Array): button_ligth_rigth._on_red_pressed()

func reste(_args) -> void: config.reset()

func apply(_args) -> void: config.apply()

func clear(_args: Array) -> void: historic.clear()

func help(_args: Array) -> void: 
	historic.append_text("""
	help ->  show this table; 
	echo <str> -> print to terminal; 
	clear, cls -> clean this terminal; 
	exit -> quit the game; 
	resolution <x:int,y:int> -> set screen resolution (x and y > 200); 
	fullscreen <bool> -> enable/disable fullscreen (true/false); 
	reste -> reset settings to defaults; 
	apply -> apply current settings; 
	show_config -> display current configuration; 
	""")

func show_config(_args: Array) -> void: 
	historic.append_text("""
	resolution : %s x %s
	fullscreen : %s
	""" % [Global.resolution.x, Global.resolution.y, Global.is_fuslcream])

func echo(args: Array) -> void: 
	if args.size() < 1:
		historic.append_text("[color=orange]Usage: echo <str>[/color] \n")
		return
	
	var text = " ".join(args)
	
	historic.append_text(str(text) + "\n")

func resolution(args: Array) -> void:
	if args.size() < 1:
		historic.append_text("[color=orange]Usage: resolution <x:int,y:int>[/color] \n")
		return
	
	var resoluct = args[0].split(",")
	
	if not resoluct[0].is_valid_int() or not resoluct[1].is_valid_int() :
		historic.append_text("[color=orange]Usage: x and y must be integers[/color] \n")
		return
		
	if resoluct[0].to_int() <= 200 or resoluct[1].to_int() <= 200:
		historic.append_text("[color=orange]Usage: x and y must be > 200[/color] \n")
		return
	
	config.resolution = Vector3i(resoluct[0].to_int(), resoluct[1].to_int(), 15)

func fullscreen(args: Array) -> void:
	if args.size() < 1:
		historic.append_text("fullscreen: " + str(Global.is_fuslcream) + "\n")
		return
	
	var state = str(args[0])
	
	if state == "true": state = 1
	elif state == "false": state = 0
	elif not state.is_valid_int(): 
		historic.append_text("[color=orange]Usage: fullscreen <bool>[/color] \n")
		return
	
	state = int(state)
	
	if not state in [1 ,0]: 
		historic.append_text("[color=orange]Usage: fullscreen <bool>[/color] \n")
		return
		
	Global.is_fuslcream = bool(state)
	
