extends Node2D

@export var level: int
var current_level = level

var time = 0
var timecart = 0

var selected_cart_item
var selected_cart_col1
var selected_cart_col2
var selected_cart_item_id

# Screens
@export var screen_store : Node2D
@export var screen_objectives : Node2D
@export var screen_cart : Node2D
@export var screen_email : Node2D
@export var screen_portrait : Node2D

# For portraits
var email_outcomes = {}
var email_outcome_index = 0

func _ready():
	fill_objectives()
	screen_store.set_label_contacts (str(screen_email.email_contact) + "/" + str(screen_email.email_contacts))
	pass
	
func _process (delta):
	time += delta
	if time > 0.25:
		fill_cart()
		if screen_objectives.button_pressed:
			screen_email.open_email()
			screen_objectives.button_pressed = false
			screen_objectives.is_email_open = screen_email.is_email_open
		time = 0

func unhide_portrait():
	screen_store.visible = false
	screen_objectives.visible = false
	screen_cart.visible = false
	screen_email.visible = false
	$TextureButtonExit.visible = false
	screen_portrait.visible = true
	screen_portrait.unhide_flash()
	screen_portrait.brightness = 255

# User level to detect 2 or 3
func game_over(email_outcomes):
	print(email_outcomes)
	for sender in email_outcomes.keys():
		print(sender)
		print (email_outcomes[sender])
		# Change portrait face for current level
		screen_portrait.change_face(sender, email_outcomes[sender])
	unhide_portrait()

# email outcomes may be a list or dict
func game_over_level_1(email_outcomes):
	for sender in email_outcomes.keys():
		print(sender)
		print (email_outcomes[sender])
		$PortraitScreenLevel1.change_face(sender, email_outcomes[sender])
	unhide_portrait()
	
func add_email_outcome():
	var emails = screen_email.get_emails(level)
	var sender_name = emails[email_outcome_index]["Sender Name"]
	var happy_item = emails[email_outcome_index]["Happy Item"]
	var neutral_items = emails[email_outcome_index]["Neutral Items"]
	email_outcome_index += 1
	# Check score
	if selected_cart_item_id == happy_item:
		email_outcomes[sender_name] = "happy"
	elif selected_cart_item_id in neutral_items:
		email_outcomes[sender_name] = "neutral"
	else:
		email_outcomes[sender_name] = "sad"
	
# Checkout button to see if you are done the level or more contacts
func add_to_cart():
	print ("level_",level,".gd: add to cart started ", email_outcomes)
	# Check if no item selected
	if not selected_cart_item_id:
		print ("level_",level,".gd: no item in cart")
		return
	# Prepare emails
	screen_email.contact_fill()
	screen_email.load_emails()
	screen_store.set_label_contacts (str(screen_email.email_contact+1) + "/" + str(screen_email.email_contacts))
	# Store how well you did choosing the right/wrong gift
	if (screen_email.email_contacts-1) != screen_email.email_contact:
		screen_email.email_contact += 1
		add_email_outcome()
	else:
		add_email_outcome()
		checkout()
	
func checkout():
	print ("level_",level,".gd: checkout started")
	if level == 1:
		game_over_level_1(email_outcomes)
	elif level == 2:
		game_over(email_outcomes)
	elif level == 3:
		game_over(email_outcomes)
	
	
func fill_cart():
	if selected_cart_item:
		screen_cart.image_item.gen_item(selected_cart_item, selected_cart_col1, selected_cart_col2)
	if (screen_email.email_contacts-1) == screen_email.email_contact:
		# Change Add to cart to checkout and update label
		screen_cart.set_checkout_label("Checkout")
	else:
		screen_cart.set_checkout_label("Add To Cart")
	
	



func fill_objectives():
	#$Objectives/LabelContact.text = $EmailScreenLevel2.email_name
	#$Objectives/LabelSubject.text = $EmailScreenLevel2.email_subject
	var gift_ideas = {	"1": "",
					 	"2": "", 
						"3": "",
						"4": ""
					}
	var c = 1
	for item in screen_email.email_gift_ideas:
		gift_ideas[str(c)] = item.strip_edges()
		#print("level1: item check", item)
		c+=1
	print("level1: item check ", gift_ideas) 
	screen_objectives.set_gift_objective("1", gift_ideas["1"])
	screen_objectives.set_gift_objective("2", gift_ideas["2"])
	screen_objectives.set_gift_objective("3", gift_ideas["3"])
	screen_objectives.set_gift_objective("4", gift_ideas["4"])
	pass
	


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_texture_button_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
