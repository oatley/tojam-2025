extends Node2D

var time = 0
var timecart = 0

var selected_cart_item
var selected_cart_col1
var selected_cart_col2
var selected_cart_item_id

var current_level = 1

func _ready():
	fill_objectives()
	pass
	

func _process (delta):
	time += delta
	timecart += delta
	if timecart > 0.25:
		fill_cart()
		timecart = 0
	if time > 0.25:
		if $Objectives.button_pressed:
			$EmailScreenLevel1.open_email()
			$Objectives.button_pressed = false
			$Objectives.is_email_open = $EmailScreenLevel1.is_email_open
		time = 0


	
func checkout():
	print ("level_1.gd: checkout started")
	var level = int(current_level)-1
	if selected_cart_item_id:
		# Happy
		var happy_item = $EmailScreenLevel1/Emails.emails_level_1[level]["Happy Item"]
		# Neutral
		var neutral_items = $EmailScreenLevel1/Emails.emails_level_1[level]["Neutral Items"]
		
		# Check score
		if selected_cart_item_id == happy_item:
			print("YOUWIN HAPPY")
		elif selected_cart_item_id in neutral_items:
			print("Not bad not bad")
		else:
			print(";-------------------------------;")
	
	
func fill_cart():
	if selected_cart_item:
		$Cart/ImageItem.gen_item(selected_cart_item, selected_cart_col1, selected_cart_col2)
	
	



func fill_objectives():
	$Objectives/LabelContact.text = $EmailScreenLevel1.email_name
	$Objectives/LabelSubject.text = $EmailScreenLevel1.email_subject
	var gift_ideas = {	"1": "",
					 	"2": "", 
						"3": "",
						"4": ""
					}
	var c = 1
	for item in $EmailScreenLevel1.email_gift_ideas:
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
