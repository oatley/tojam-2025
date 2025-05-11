extends Node2D

# Control
var level = 1

# Email
var email_from = "from@email.com"
var email_to = "to@email.com"
var email_subject = "subject"
var email_body = "email body"
var email_name = "sender_name"
var email_gift_ideas = []

# Control
var is_email_open = false

func _ready():
	load_level_1_emails(0)
	#email_fill(email_from, email_to, email_subject, email_body)



# Give int, start from zero
func load_level_1_emails(email_number=0):
	email_from = $Emails.emails_level_1[email_number]["Email Address"]
	email_to = "fred.main_character@TOJam.com"
	email_subject = $Emails.emails_level_1[email_number]["Subject Line"]
	email_body = $Emails.emails_level_1[email_number]["Email Body"]
	email_name = $Emails.emails_level_1[email_number]["Sender Name"]
	email_gift_ideas = $Emails.emails_level_1[email_number]["Email Tags"].split(",")
	#print("email_screen_level_1: gift ideas ", $Emails.emails_level_1[email_number]["Email Tags"])
	email_fill(email_from, email_to, email_subject, email_body)
	contact_fill(email_name, email_subject)

func contact_fill(contact_name, contact_subject):
	var contact = $EmailLayout/ScrollContainer/VBoxContainer/TextureButtonContact1/LabelContact
	var subject = $EmailLayout/ScrollContainer/VBoxContainer/TextureButtonContact1/LabelSubject
	contact.text = contact_name
	subject.text = contact_subject

func email_fill(from, to, subject, body):
	$EmailLayout/LabelFrom.text = email_from
	$EmailLayout/LabelTo.text = to
	$EmailLayout/LabelSubject.text = subject
	$EmailLayout/LabelBody.text = body

func close_email():
	$EmailLayout.visible = false
	is_email_open = false

func open_email():
	$EmailLayout.visible = true
	is_email_open = true
	

func _on_texture_button_exit_pressed() -> void:
	$EmailLayout.visible = false
	pass # Replace with function body.
