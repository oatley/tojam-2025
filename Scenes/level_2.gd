extends Node2D

var time = 0
var timecart = 0

var selected_cart_item
var selected_cart_col1
var selected_cart_col2
var selected_cart_item_id

var level = 2
var current_level = level


func set_level():
	$StoreLevel2.level = level
	$Objectives.level = level
	$Cart.level = level
	$EmailScreenLevel2.level = level
	$PortraitScreenLevel2.level = level

func _ready():
	fill_objectives()
	set_level()
	pass
	

func _process (delta):
	time += delta
	if time > 0.25:
		fill_cart()
		if $Objectives.button_pressed:
			$EmailScreenLevel2.open_email()
			$Objectives.button_pressed = false
			$Objectives.is_email_open = $EmailScreenLevel2.is_email_open
		time = 0


func unhide_portrait():
	if level == 2:
		$StoreLevel2.visible = false
		$Objectives.visible = false
		$Cart.visible = false
		$EmailScreenLevel2.visible = false
		$TextureButtonExit.visible = false
		$PortraitScreenLevel2.visible = true
		$PortraitScreenLevel2/TextureRectFlash.visible = true
		$PortraitScreenLevel2.brightness = 255
	elif level == 3:
		$StoreLevel3.visible = false
		$Objectives.visible = false
		$Cart.visible = false
		$EmailScreenLevel3.visible = false
		$TextureButtonExit.visible = false
		$PortraitScreenLevel3.visible = true
		$PortraitScreenLevel3/TextureRectFlash.visible = true
		$PortraitScreenLevel3.brightness = 255
	
# User level to detect 2 or 3
func game_over(email_outcomes):
	for sender in email_outcomes.keys():
		print(sender)
		print (email_outcomes[sender])
		if level == 1:
			$PortraitScreenLevel1.change_face(sender, email_outcomes[sender])
		elif level == 2:
			$PortraitScreenLevel2.change_face(sender, email_outcomes[sender])
		elif level == 3:
			$PortraitScreenLevel3.change_face(sender, email_outcomes[sender])
	unhide_portrait()

# email outcomes may be a list or dict
func game_over_level_1(email_outcomes):
	for sender in email_outcomes.keys():
		print(sender)
		print (email_outcomes[sender])
		$PortraitScreenLevel1.change_face(sender, email_outcomes[sender])
	unhide_portrait()
	
	
func add_to_cart():
	print ("level_",level,".gd: add to cart started")
	if ($EmailScreenLevel2.email_contacts-1) != $EmailScreenLevel2.email_contact:
		$EmailScreenLevel2.email_contact += 1
		$EmailScreenLevel2.contact_fill()
		$EmailScreenLevel2.load_emails()
		$StoreLevel2/LabelContacts.text = str($EmailScreenLevel2.email_contact+1) + "/" + str($EmailScreenLevel2.email_contacts)
	else:
		checkout()
	
func checkout():
	print ("level_",level,".gd: checkout started")
	var index = level-1
	var email_outcomes = {}
	var emails
	if level == 1:
		emails = $EmailScreenLevel1/Emails.emails_level_1
	elif level == 2:
		emails = $EmailScreenLevel2/Emails.emails_level_2
	elif level == 3:
		emails = $EmailScreenLevel3/Emails.emails_level_1
	if selected_cart_item_id:
		# who
		#var sender_name = $EmailScreenLevel1/Emails.emails_level_1[level]["Sender Name"]
		var sender_name = emails[index]["Sender Name"]
		# Happy
		#var happy_item = $EmailScreenLevel1/Emails.emails_level_1[level]["Happy Item"]
		var happy_item = emails[index]["Happy Item"]
		# Neutral
		#var neutral_items = $EmailScreenLevel1/Emails.emails_level_1[level]["Neutral Items"]
		var neutral_items = emails[index]["Neutral Items"]
		
		# Check score
		if selected_cart_item_id == happy_item:
			email_outcomes[sender_name] = "happy"
		elif selected_cart_item_id in neutral_items:
			email_outcomes[sender_name] = "neutral"
		else:
			email_outcomes[sender_name] = "sad"
		if level == 1:
			game_over_level_1(email_outcomes)
		elif level == 2:
			game_over(email_outcomes)
		elif level == 3:
			game_over(email_outcomes)
	
	
func fill_cart():
	if selected_cart_item:
		$Cart/ImageItem.gen_item(selected_cart_item, selected_cart_col1, selected_cart_col2)
	if ($EmailScreenLevel2.email_contacts-1) == $EmailScreenLevel2.email_contact:
		# Change Add to cart to checkout and update label
		$Cart/TextureButtonCheckout/LabelCheckout.text = "Checkout"
	else:
		$Cart/TextureButtonCheckout/LabelCheckout.text = "Add To Cart"
	
	



func fill_objectives():
	#$Objectives/LabelContact.text = $EmailScreenLevel2.email_name
	#$Objectives/LabelSubject.text = $EmailScreenLevel2.email_subject
	var gift_ideas = {	"1": "",
					 	"2": "", 
						"3": "",
						"4": ""
					}
	var c = 1
	for item in $EmailScreenLevel2.email_gift_ideas:
		gift_ideas[str(c)] = item.strip_edges()
		#print("level1: item check", item)
		c+=1
	print("level1: item check ", gift_ideas) 
	$Objectives/LabelGiftIdeasObjective1.text = gift_ideas["1"]
	$Objectives/LabelGiftIdeasObjective2.text = gift_ideas["2"]
	$Objectives/LabelGiftIdeasObjective3.text = gift_ideas["3"]
	$Objectives/LabelGiftIdeasObjective4.text = gift_ideas["4"]
	pass
	


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_texture_button_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
