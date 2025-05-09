extends Node2D

var data_header = []
var items = []
var filename = "test.csv" 
var item_general_categories = []
var item_specific_categories = []

func _ready():
	read_item_file()
	get_parent().tabs = item_general_categories
	pass

# Read the data from the items csv file and make a list of items
# Each item is a dictionary sorted by the header line
# list = [item, item, ...]
# item = {cat: "toy", ...}
func read_item_file():
	var file
	# Open file for reading
	file = FileAccess.open(filename, FileAccess.READ)
	if file:	
		print("store.gd: opened file " + filename)
		while not file.eof_reached():
			var line = file.get_line()
			var item_dict: Dictionary = {}
			var count = 0
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
				if linelist[0] not in item_general_categories:
					item_general_categories.append(linelist[0])
				# Add to specific categories
				if linelist[1] not in item_specific_categories:
					item_specific_categories.append(linelist[1])
				# Create a new dictionary for each line
				for header in data_header:
					i[header] = linelist[c] 
					c+=1
				items.append(i)
		file.close()
		#print (items)
		print ("store.gd: data loaded successfully " + filename)
	else:
		print("store.gd: Error: could not open file")
