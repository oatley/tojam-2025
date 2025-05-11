extends Node2D

var data_header = []
var items = []
var filename = "item_storage.tsv" 
var item_general_categories = []
var item_specific_categories = []
var isReady = false

# ImageItems
var image_items = {}
var image = {}

func _ready():
	read_item_file()
	#get_parent().tab_names = item_general_categories # seems like parent can read
	pass

func generate_image_items():
	for item in items:
		image = {"image": item["Art Asset"], "Colour 1": item["Colour 1"], "Colour 2": item["Colour 2"]}
	pass
	
func read_item_file():
	var file
	var count = 0
	# Open file for reading
	file = FileAccess.open(filename, FileAccess.READ)
	if file:	
		print("items.gd: opened file " + filename)
		while not file.eof_reached():
			var line = file.get_line()
			var item_dict: Dictionary = {}
			# Get the first line which contains table headers
			if count == 0:
				data_header = line.split("\t")
				count += 1
			# Process data lines	
			else:
				#print (line)
				var linelist = line.split("\t")
				var i: Dictionary = {}
				var c = 0
				# Add to general categories
				#print ("items.gd: linelist ", linelist)
				if linelist[0] and linelist[0] not in item_general_categories:
					#print("items.gd: add to gen cat", linelist[0])
					item_general_categories.append(linelist[0])
				# Add to specific categories
				if linelist[1] and linelist[1] not in item_specific_categories:
					item_specific_categories.append(linelist[1])
				# Create a new dictionary for each line
				for header in data_header:
					i[header] = linelist[c] 
					c+=1
				items.append(i)
		file.close()
		#print ("items.gd: ", items)
		#print  ("items.gd: general categories ", item_general_categories)
		#print  ("items.gd: specific categories ", item_specific_categories)
		print ("items.gd: data loaded successfully " + filename)
		
	else:
		print("items.gd: Error: could not open file")



# Do not change with this!!!
func read_item_file_old():
	var file
	var count = 0
	# Open file for reading
	file = FileAccess.open(filename, FileAccess.READ)
	if file:	
		print("items.gd: opened file " + filename)
		while not file.eof_reached():
			var line = file.get_line()
			var item_dict: Dictionary = {}
			# Get the first line which contains table headers
			if count == 0:
				data_header = line.split(",")
				count += 1
			# Process data lines	
			else:
				var linelist = line.split(",")
				var i: Dictionary = {}
				var c = 0
				# Add to general categories
				if linelist[0] and linelist[0] not in item_general_categories:
					#print("items.gd: add to gen cat", linelist[0])
					item_general_categories.append(linelist[0])
				# Add to specific categories
				if linelist[1] and linelist[1] not in item_specific_categories:
					item_specific_categories.append(linelist[1])
				# Create a new dictionary for each line
				for header in data_header:
					i[header] = linelist[c] 
					c+=1
				items.append(i)
		file.close()
		#print ("items.gd: ", items)
		#print  ("items.gd: general categories ", item_general_categories)
		#print  ("items.gd: specific categories ", item_specific_categories)
		print ("items.gd: data loaded successfully " + filename)
		
	else:
		print("items.gd: Error: could not open file")


func _on_ready() -> void:
	isReady = true
	print("items.gd: ready")
	pass # Replace with function body.
