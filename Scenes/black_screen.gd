extends Node2D

@export var level: int

var portrait = false
var start = true
var default_time = 75
var time = default_time
var default_alpha = 300
var alpha = default_alpha

# Enable fade
var fade = true


func _ready() -> void:
	screen_control()

func set_time():
	time = default_time

func set_alpha_start():
	alpha = default_alpha

func set_alpha_end():
	alpha = 0

func set_label_year (text):
	$LabelYear.text = text
	
func modulate_screen():
	var black_colour = Color.from_rgba8(15,15,15,alpha)
	var white_colour = Color.from_rgba8(255,255,255,alpha)
	$TextureRect.modulate = black_colour
	$LabelYear.modulate = white_colour

func change_alpha():
	if start:
		alpha -= 4
	elif portrait:
		alpha += 4

func change_time():
	if start:
		time -= 1
	elif portrait:
		time += 1


func screen_control():
	change_time()
	if time <= 0:
		change_alpha()

	modulate_screen()
	if level == 1 and start: # Show start screen level 1
		self.visible = true
		set_label_year("Mar 17, 1990")
	elif level == 1 and not start and portrait: # Show end screen after clicking continue 1
		self.visible = true
		set_label_year("6 Years Later")
	elif level == 2 and start: # Show start screen level 2
		self.visible = true
		set_label_year("Dec 05, 1996")
	elif level == 2 and not start and portrait: # Show end screen after clicking continue 2
		self.visible = true
		set_label_year("15 Years Later")
	elif level == 3 and start: # Show start screen level 3
		self.visible = true
		set_label_year("Nov 29, 2021")
	elif level == 3 and not start and portrait: # Show end screen after clicking continue 3
		self.visible = true
		set_label_year("The End")
	else:
		self.visible = false
