extends Node2D

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

var alpha = 255

# Colours
var red = Color.from_rgba8(153, 21, 21, alpha)
var orange = Color.from_rgba8 (254, 112, 0, alpha)
var yellow = Color.from_rgba8 (232, 234, 74, alpha)
var green = Color.from_rgba8 (99, 179, 29, alpha)
var blue = Color.from_rgba8 (0, 106, 180, alpha)
var purple = Color.from_rgba8 (150, 0, 220, alpha)
var pink = Color.from_rgba8 (254, 72, 222, alpha)
var brown = Color.from_rgba8(81, 48, 2, alpha)
#var white = Color.from_rgba8(237, 233, 218, alpha) # Old bad white
var white = Color.from_rgba8(255, 237, 212, alpha)
var black = Color.from_rgba8(0, 0, 0, alpha)
# Pastel colours
var light_red = Color.from_rgba8(204, 138, 138, alpha)
var light_orange = Color.from_rgba8(255, 184, 128, alpha)
var light_yellow = Color.from_rgba8(244, 245, 165, alpha)
var light_green = Color.from_rgba8(177, 217, 142, alpha)
var light_blue = Color.from_rgba8(128, 181, 218, alpha)
var light_purple = Color.from_rgba8(203, 128, 238, alpha)
var light_pink = Color.from_rgba8(255, 164, 239, alpha)
# Metals
var silver = Color.from_rgba8(100, 164, 164, alpha)

# Match string to colours
var colour_dict = {	"Red": red,
					"Orange": orange, 
					"Yellow": yellow, 
					"Green": green,
					"Blue": blue, 
					"Purple": purple, 
					"Pink": pink, 
					"Brown": brown, 
					"White": white, 
					"Black": black, 
					"Light Red": light_red, 
					"Light Orange": light_orange,
					"Light Yellow": light_yellow, 
					"Light Green": light_green,
					"Light Blue": light_blue, 
					"Light Purple": light_purple,
					"Light Pink": light_pink, 
					"Silver": silver,
					"None": white}

# This should set all filenames
func gen_item(image, col1, col2):
	item_art_asset = image
	
	# Generate the base image filename
	gen_base_file(image)	
	
	# Check if colour 1 exists
	if col1 not in colour_dict.keys():
		print ("image_item.gd: Error: detected missing colour -> image: ", image, " colour -> ", col1)
	else:
		item_col1 = col1
		
	# Check if colour 2 exists
	if col2 not in colour_dict.keys():
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
		
# Load texture for base file when passed a string with the art asset name
func gen_base_file(image):
	image_file_base = image + "Base.png"
	var res = "res://Assets/Items/" + image_file_base
	if not ResourceLoader.exists(res):
		print("image_item.gd: Error: file does not exist ", res)
		return
	#$TextureRectBase.texture = load("res://Assets/Items/" + image_file_base)
	$TextureRectBase.texture = load(res)

# Load texture for col1 when passed a string with the art asset name
func gen_col1_file(image, col1):
	image_file_col1 = image + "Col1.png"
	var res = "res://Assets/Items/" + image_file_col1
	if not ResourceLoader.exists(res):
		print("image_item.gd: Error: file does not exist ", res)
		return
	#$TextureRectColour1.texture = load("res://Assets/Items/" + image_file_col1)
	$TextureRectColour1.texture = load(res)
	
# Load texture for col2 when passed a string with the art asset name
func gen_col2_file(image, col2):
	image_file_col2 = image + "Col2.png"
	var res = "res://Assets/Items/" + image_file_col2
	if not ResourceLoader.exists(res):
		print("image_item.gd: Error: file does not exist ", res)
		return
	#$TextureRectColour2.texture = load("res://Assets/Items/" + image_file_col2)
	$TextureRectColour2.texture = load(res)
	
# The two different colour layers must modulate to string colour provided
func set_colour(colour_number, colour):
	if colour_number == 0:
		var col = get_colour(colour)
		if colour == "None": # Probably don't need this but safety
			$TextureRectColour1.visible = false
		else:
			$TextureRectColour1.visible = true
			$TextureRectColour1.modulate = col
	elif colour_number == 1:
		var col = get_colour(colour)
		if colour == "None": # Probably don't need this but safety
			$TextureRectColour2.visible = false
		else:
			$TextureRectColour2.visible = true
			$TextureRectColour2.modulate = col
	pass

# Convert colour string requested to the rgb colour object using colour_dict
func get_colour(colour):
	if colour not in colour_dict.keys():
		print ("image_item.gd: Error: Colour does not exist in list -> ", colour)
		return white
	return colour_dict[colour]
