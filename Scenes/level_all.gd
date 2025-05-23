extends Node2D

@export var level: int
var current_level = level
var main_menu = "res://Scenes/main.tscn"

# Control
var time = 0
var timecart = 0
var black_screen_time = 0

# black screen fade/time switch
var fade_alpha_time

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
@export var screen_black : Node2D

# Sound Effects
@export var sound_click: AudioStreamPlayer
@export var sound_email: AudioStreamPlayer
@export var sound_camera: AudioStreamPlayer
@export var sound_cash: AudioStreamPlayer

# For portraits
var email_outcomes = {}
var email_outcome_index = 0

func _ready():
	fill_objectives()
	screen_store.set_label_contacts ("0/" + str(screen_email.email_contacts))
	
func _process (delta):
	time += delta
	black_screen_time += delta
	
	if black_screen_time > 0.1:
		screen_black.screen_control()
	
	if time > 0.25:
		fill_cart()
			
		if screen_objectives.button_pressed and screen_black.alpha <= 0:
		#if screen_objectives.button_pressed and screen_black.time <= 0:
			screen_black.start = false
			screen_black.portrait = false
			#screen_black.visible = false
			sound_email.play()
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

# Update portrait faces and unhide the portrait screen
func game_over(email_outcomes):
	for sender in email_outcomes.keys():
		# Change portrait face for current level
		screen_portrait.change_face(sender, email_outcomes[sender])
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
	
# Clear item from cart
func clear_item_from_cart():
		screen_cart.image_item.hide_item()
		selected_cart_item_id = ""
		selected_cart_item = ""
		selected_cart_col1 = ""
		selected_cart_col2 = ""
		
# Checkout button to see if you are done the level or more contacts
func add_to_cart():
	# Check if no item selected
	if not selected_cart_item_id:
		print ("level_all.gd: no item in cart")
		return
	
	# More contacts
	if (screen_email.email_contacts-1) != screen_email.email_contact:
		add_email_outcome()
		print("level_all.gd: add to cart ", email_outcomes)
		for key in email_outcomes:
			screen_email.hide_contact_button ()
		screen_email.email_contact += 1
		screen_email.contact_fill()
		screen_email.load_emails()
		fill_objectives()
		screen_store.set_label_contacts (str(screen_email.email_contact) + "/" + str(screen_email.email_contacts))
		screen_objectives.button_pressed = true # This will force a delayed open of the email screen
		clear_item_from_cart()
	else: # No more contacts, show portrait screen
		add_email_outcome()
		print("level_all.gd: checkout ", email_outcomes)
		checkout()
	
func checkout():
	print ("level_",level,".gd: checkout started")
	if level == 1:
		game_over(email_outcomes)
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
	screen_objectives.set_label_contact(screen_email.email_name)
	screen_objectives.set_label_subject(screen_email.email_subject)
	#profile pic var profile = "res://Assets/Pic_" + emails[count]["Sender Name"] + str(level) + ".png"
	var profile = "res://Assets/Pic_" + screen_email.email_name + str(level) + ".png"
	screen_objectives.set_profile_pic(profile)
	
	
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
	
func load_main_menu():
	get_tree().change_scene_to_file(main_menu)

# Loop the background music
func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()

# Clicking the X button in the corner of the screen
func _on_texture_button_exit_pressed() -> void:
	load_main_menu()

# Exit button click
func _on_texture_button_exit_button_down() -> void:
	sound_click.play()
