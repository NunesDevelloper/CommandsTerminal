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
	"clear": clear,
	"cls":clear,
	"echo": echo,
	"help":help,
	"exit":exit,
	"resoluction":resoluction
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

func help(_args: Array) -> void: 
	historic.append_text("""
	help ->  show this table; 
	echo <str> -> print to terminal; 
	clear, cls -> clean this terminal; 
	start -> enters the stage selection screen; 
	exit -> quit the game; 
	config -> enters the settings screen; 
	""")

func clear(_args: Array) -> void: historic.clear()

func echo(args: Array) -> void: 
	if args.size() < 1:
		historic.append_text("[color=orange]Usage: echo <str>[/color] \n")
		return
	
	var text = " ".join(args)
	
	historic.append_text(str(text) + "\n")

func resoluction(args: Array) -> void:
	if args.size() < 1:
		historic.append_text("[color=orange]Usage: resoluction <x:int,y:int>[/color] \n")
		return
	
	var resoluct = args[0].split(",")
	
	if not resoluct[0].is_valid_int() or not resoluct[1].is_valid_int() :
		historic.append_text("[color=orange]Usage: x and y somente tipo int[/color] \n")
		return
		
	if resoluct[0].to_int() <= 200 or resoluct[1].to_int() <= 200:
		historic.append_text("[color=orange]Usage: x and y > 200[/color] \n")
		return
	
	config.resoluction = Vector3i(resoluct[0].to_int(), resoluct[1].to_int(), 15)
	
	
