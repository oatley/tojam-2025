extends Node2D

# Control
#var number_of_colours = 0
#var list_of_colours = []

# From data sheet
var item_art_asset = ""
var item_col1 = ""
var item_col2 = ""
var item_id = ""

# Generate filenames to load
var image_file_base = ""
var image_file_col1 = ""
var image_file_col2 = ""
var image_file_fallback = "BoxBase.png"

# Colours
var colours = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "Brown", "White", "Black", "None"]
var red = Color.from_rgba8(153, 21, 21, 255)
var orange = Color.from_rgba8 (254, 112, 0, 255)
var yellow = Color.from_rgba8 (232, 234, 74, 255)
var green = Color.from_rgba8 (99, 179, 29, 255)
var blue = Color.from_rgba8 (0, 106, 180, 255)
var purple = Color.from_rgba8 (150, 0, 220, 255)
var pink = Color.from_rgba8 (254, 72, 222, 255)
var brown = Color.from_rgba8(81, 48, 2, 255)
# White 237, 233, 218
var white = Color.from_rgba8(237, 233, 218, 255)
var black = Color.from_rgba8(0, 0, 0, 255)



# Dynamic generate items and load images based on "Art Asset" "Colour 1" "Colour 2"

# Item image dictionary ????
# image_items = {"Art Asset": {"Image": imagebase, "Colour 1": colour1, "Colour 2": colour2},...}
# image = {"Image": imagebase, "Colour 1": colour1, "Colour 2": colour2}


# This should set all filenames
func gen_item(image, col1, col2):
	item_art_asset = image
	
	# Generate the base image filename
	gen_base_file(image)	
	
	# Check if colour 1 exists
	if col1 not in colours:
		print ("image_item.gd: Error: detected missing colour -> image: ", image, " colour -> ", col1)
	else:
		item_col1 = col1
		
	# Check if colour 2 exists
	if col2 not in colours:
		print ("image_item.gd: Error: detected missing colour -> image: ", image, " colour -> ", col2)
	else:
		item_col2 = col2
		
	# Check if there is no colour file
	if col1 != "None":
		gen_col1_file(image, col1)
		set_colour(0, col1)
	else:
		$TextureRectColour1.visible = false
	
	# Check if there is no colour file
	if col2 != "None":
		gen_col2_file(image, col2)
		set_colour(1, col2)
	else:
		$TextureRectColour2.visible = false

	
	# Should I use file_exists to see if the file exists and then ResourceLoader only for after load?
	# Issue is for EXPORTING because there are no files after export!
	
	#if ResourceLoader.exists("res://Assets/Items/" + image_file_base):
		#print("image_item.gd: file exists -> ", image_file_base)
	#else:
		#print("image_item.gd: Error: file does not exist, using fallback... -> ", image_file_base)
		#image_file_base = image_file_fallback
		
# Load texture for base file
func gen_base_file(image):
	#print ("WHAT IS ", image)
	#image_file_base = image.strip_edges() + "Base.png"
	image_file_base = image + "Base.png"
	var res = "res://Assets/Items/" + image_file_base
	if not ResourceLoader.exists(res):
		print("image_item.gd: Error: file does not exist ", res)
		pass
	$TextureRectBase.texture = load("res://Assets/Items/" + image_file_base)

# Load texture for col1
func gen_col1_file(image, col1):
	image_file_col1 = image+ "Col1.png"
	var res = "res://Assets/Items/" + image_file_col1
	if not ResourceLoader.exists(res):
		print("image_item.gd: Error: file does not exist ", res)
		pass
	#var res = "res://Assets/Items/" + image_file_col1
	#if ResourceLoader.exists(res):
		#print("exits ", res)
	$TextureRectColour1.texture = load("res://Assets/Items/" + image_file_col1)
	
# Load texture for col2
func gen_col2_file(image, col2):
	image_file_col2 = image + "Col2.png"
	var res = "res://Assets/Items/" + image_file_col2
	if not ResourceLoader.exists(res):
		print("image_item.gd: Error: file does not exist ", res)
		pass
	$TextureRectColour2.texture = load("res://Assets/Items/" + image_file_col2)


func set_image(image):
	pass
	
	
func set_colour(colour_number, colour):
	
	#if colour == "None" or colour == "" or colour not in colours:
		#pass

	if colour_number == 0:
		var col = get_colour(colour)
		#print(col)
		if colour == "None":
			$TextureRectColour1.visible = false
		else:
			$TextureRectColour1.visible = true
			$TextureRectColour1.modulate = col
	elif colour_number == 1:
		var col = get_colour(colour)
		#print(col)
		if colour == "None":
			$TextureRectColour2.visible = false
		else:
			$TextureRectColour2.visible = true
			$TextureRectColour2.modulate = col
	pass

func get_colour(colour):
	if colour not in colours:
		print ("image_item.gd: Error: Colour does not exist in list -> ", colour) 
	var col
	if colour == "Red":
		col = red
	elif colour == "Orange":
		col = orange
	elif colour == "Yellow":
		col = yellow
	elif colour == "Green":
		col = green
	elif colour == "Blue":
		col = blue
	elif colour == "Purple":
		col = purple
	elif colour == "Pink":
		col = pink
	elif colour == "Brown":
		col = brown
	elif colour == "White":
		col = white
	elif colour == "Black":
		col = black
	else:
		col = red
	return col
