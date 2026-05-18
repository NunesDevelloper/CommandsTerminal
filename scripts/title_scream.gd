extends Control

@onready var historic: RichTextLabel = $terminal/historic
@onready var input: LineEdit = $terminal/input

func _on_start_button_down() -> void:
	historic.append_text("start\n")

func _on_config_button_down() -> void:
	historic.append_text("config\n")

func _on_exit_button_down() -> void:
	get_tree().quit()

#region terminal
var commands = {
	"clear": clear,
	"exit": exit,
	"start": start,
	"config": config,
	"echo": echo
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

func clear(_args: Array) -> void: historic.clear()

func echo(args: Array) -> void: 
	if args.size() < 1:
		historic.append_text("[color=orange]Usage: echo <str>[/color] \n")
		return
	
	var text = " ".join(args)
	
	historic.append_text(str(text) + "\n")

func start(_args : Array) -> void: _on_start_button_down()

func exit(_args : Array) -> void: _on_exit_button_down()

func config(_args : Array) -> void: _on_config_button_down()
#endregion 
