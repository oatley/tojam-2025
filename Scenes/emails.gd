extends Node2D

var filename = "email_storage.tsv"
var data_header = []
var emails = []
var emails_level_1 = []
var emails_level_2 = []
var emails_level_3 = []

var level = 1



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
			# Get the first line which contains table headers
			if count == 0:
				data_header = line.split("\t")
				#print (data_header)
				count += 1
			# Process data lines	
			else:
				var linelist = line.split("\t")
				var e: Dictionary = {}
				var c = 0
					
				# Create a new dictionary for each line
				for header in data_header:
					e[header] = linelist[c] 
					# Detect and store neutral
					if c == 8 and linelist[c]:
						#print(linelist[c])
						var neutral = []
						neutral = linelist[c].split(",")
						#print(neutral[5])
					c+=1
				emails.append(e)
		file.close()
		for email in emails:
			if email["Level"] == "1":
				emails_level_1.append(email)
			if email["Level"] == "2":
				emails_level_2.append(email)
			if email["Level"] == "3":
				emails_level_3.append(email)
		#print(emails_level_1)
		print("emails.gd: number of emails in level 1: -> ", len(emails_level_1))
		print("emails.gd: number of emails in level 2: -> ", len(emails_level_2))
		print("emails.gd: number of emails in level 2: -> ", len(emails_level_3))
		#print ("items.gd: ", items)
		#print ("emails.gd: ", emails )
		print ("emails.gd: data loaded successfully " + filename)
	else:
		print("emails.gd: Error: could not open file")
