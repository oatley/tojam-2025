extends Node2D

@export var level: int

# Email
var email_from = "from@email.com"
var email_to = "to@email.com"
var email_subject = "subject"
var email_body = "email body"
var email_name = "sender_name"
var email_gift_ideas = []
var email_happy_item = ""
var email_neutral_items = []

# Controls
var email_block_disabled_off = load("res://Assets/tojam25_emailBlock1_Off.png")
var email_block_disabled_over = load("res://Assets/tojam25_emailBlock1_Over.png")
var email_block_enabled_off = load("res://Assets/tojam25_emailBlock2_Off.png")
var email_block_enabled_over = load("res://Assets/tojam25_emailBlock2_Over.png")
var email_contact = 0
var email_contacts = set_contacts()

# Control
var is_email_open = false
var contact_buttons = []

func set_contacts():
	var contacts = 0
	if level == 1:
		contacts = 1
	elif level == 2:
		contacts = 4
	elif level == 3:
		contacts = 9
	return contacts
	
func disable_contact_buttons():
	for i in range(1,10):
		var button = find_child("TextureButtonContact"+str(i))
		button.visible = false
		
func find_contact_buttons():
	for i in range(1,email_contacts+1):
		var button = find_child("TextureButtonContact"+str(i))
		button.visible = true
		contact_buttons.append(button)
	
func hide_contact_button():
	var i = email_contact+1 # nodes have 1 high number than contact
	var button = find_child("TextureButtonContact"+str(i))
	button.visible = false
		
func _ready():
	load_emails()
	email_contacts = set_contacts()
	disable_contact_buttons()
	find_contact_buttons()
	contact_fill()
	
func set_tooltip():
	pass
	
func get_emails(level):
	var emails
	if level == 1:
		emails = $Emails.emails_level_1
	elif level == 2:
		emails = $Emails.emails_level_2
	elif level == 3:
		emails = $Emails.emails_level_3
	return emails
	
func load_emails ():
	if level == 1:
		load_level_1_emails(email_contact)
	elif level == 2:
		load_level_2_email(email_contact)
	elif level == 3:
		load_level_3_email(email_contact)	
	$EmailLayout.visible = true

func load_level_3_email(email_number=0):
	email_from = $Emails.emails_level_3[email_number]["Email Address"]
	email_to = "fred.main_character@TOJam.com"
	email_subject = $Emails.emails_level_3[email_number]["Subject Line"]
	email_body = $Emails.emails_level_3[email_number]["Email Body"]
	email_name = $Emails.emails_level_3[email_number]["Sender Name"]
	email_gift_ideas = $Emails.emails_level_3[email_number]["Email Tags"].split(",")
	email_happy_item = $Emails.emails_level_3[email_number]["Happy Item"]
	email_neutral_items = $Emails.emails_level_3[email_number]["Neutral Items"].split(",")
	#print("email_screen_level_1: gift ideas ", $Emails.emails_level_1[email_number]["Email Tags"])
	email_fill(email_from, email_to, email_subject, email_body)		

func load_level_2_email(email_number=0):
	email_from = $Emails.emails_level_2[email_number]["Email Address"]
	email_to = "fred.main_character@TOJam.com"
	email_subject = $Emails.emails_level_2[email_number]["Subject Line"]
	email_body = $Emails.emails_level_2[email_number]["Email Body"]
	email_name = $Emails.emails_level_2[email_number]["Sender Name"]
	email_gift_ideas = $Emails.emails_level_2[email_number]["Email Tags"].split(",")
	email_happy_item = $Emails.emails_level_2[email_number]["Happy Item"]
	email_neutral_items = $Emails.emails_level_2[email_number]["Neutral Items"].split(",")
	#print("email_screen_level_1: gift ideas ", $Emails.emails_level_1[email_number]["Email Tags"])
	email_fill(email_from, email_to, email_subject, email_body)

# Give int, start from zero
func load_level_1_emails(email_number=0):
	#print($Emails.emails_level_1[email_number])
	email_from = $Emails.emails_level_1[email_number]["Email Address"]
	email_to = "fred.main_character@TOJam.com"
	email_subject = $Emails.emails_level_1[email_number]["Subject Line"]
	email_body = $Emails.emails_level_1[email_number]["Email Body"]
	email_name = $Emails.emails_level_1[email_number]["Sender Name"]
	email_gift_ideas = $Emails.emails_level_1[email_number]["Email Tags"].split(",")
	email_happy_item = $Emails.emails_level_1[email_number]["Happy Item"]
	email_neutral_items = $Emails.emails_level_1[email_number]["Neutral Items"].split(",")
	#print("email_screen_level_1: gift ideas ", $Emails.emails_level_1[email_number]["Email Tags"])
	email_fill(email_from, email_to, email_subject, email_body)

func contact_fill():
	var count = 0
	var emails
	if level == 1:
		emails = $Emails.emails_level_1
	elif level == 2:
		emails = $Emails.emails_level_2
	elif level == 3:
		emails = $Emails.emails_level_3
	#print(contact_buttons)
	#for button in contact_buttons:
	if emails:
		print("email_screen_all: emails do exist")
	else:
		print("email_screen_all: emails do NOT exist")
	for i in range (0, len(emails)):
		#print (contact_buttons)
		var button = contact_buttons[i]
		button.get_node("LabelContact").text = emails[count]["Sender Name"]
		button.get_node("LabelSubject").text = emails[count]["Subject Line"]
		var profile = "res://Assets/Pic_" + emails[count]["Sender Name"] + str(level) + ".png"
		button.get_node("TextureRectContact").texture = load(profile)
		if count == email_contact:
			button.texture_normal = email_block_enabled_off
			button.texture_hover = email_block_enabled_over
		else:
			button.texture_normal = email_block_disabled_off
			button.texture_hover = email_block_disabled_over
		#button.tooltip_text = emails[count]["Email Address"]
		count += 1

func email_fill(from, to, subject, body):
	$EmailLayout/LabelFrom.text = email_from
	$EmailLayout/LabelTo.text = to
	$EmailLayout/LabelSubject.text = subject
	$EmailLayout/ScrollContainer2/VBoxContainer/LabelBody.text = body

func close_email():
	$EmailLayout.visible = false
	is_email_open = false

func open_email():
	$EmailLayout.visible = true
	is_email_open = true
	

func _on_texture_button_exit_pressed() -> void:
	$EmailLayout.visible = false
	pass # Replace with function body.
