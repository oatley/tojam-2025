extends Node2D

var filename = "email.tsv"
var data_header = []
var emails = []

func _ready():
	read_email_file()
	#get_parent().tab_names = item_general_categories # seems like parent can read
	pass

func read_email_file():
	var file
	var count = 0
	# Open file for reading
	file = FileAccess.open(filename, FileAccess.READ)
	if file:	
		print("emails.gd: opened file " + filename)
		while not file.eof_reached():
			var line = file.get_line()
			var item_dict: Dictionary = {}
			# Get the first line which contains table headers
			if count == 0:
				data_header = line.split()
				count += 1
			# Process data lines	
			else:
				var linelist = line.split()
				var e: Dictionary = {}
				var c = 0
				# Create a new dictionary for each line
				for header in data_header:
					e[header] = linelist[c] 
					c+=1
				emails.append(e)
		file.close()
		#print ("items.gd: ", items)
		print ("emails.gd: data loaded successfully " + filename)
	else:
		print("emails.gd: Error: could not open file")
