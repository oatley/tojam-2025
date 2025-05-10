extends Node2D

# Control
var level = 1

# Email
var email_from = "from@email.com"
var email_to = "to@email.com"
var email_subject = "subject"
var email_body = "email body"

func _ready():
	email_fill(email_from, email_to, email_subject, email_body)

# Give int, start from zero
func load_level_1_emails(email_number=0):
	email_from = $Emails.emails_level_1[email_number]["Email Address"]
	email_to = "fred.main_character@TOJam.com"
	email_subject = $Emails.emails_level_1[email_number][""]

func email_fill(from, to, subject, body):
	$EmailLayout/LabelFrom.text = email_from
	$EmailLayout/LabelTo.text = to
	$EmailLayout/LabelSubject.text = subject
	$EmailLayout/LabelBody.text = body

func _on_texture_button_exit_pressed() -> void:
	$EmailLayout.visible = false
	pass # Replace with function body.
