extends Node2D

var time = 0

func _ready():
	fill_objectives()
	pass
	

func _process (delta):
	time += delta
	if time > 0.25:
		if $Objectives.button_pressed:
			$EmailScreenLevel1.open_email()
			$Objectives.button_pressed = false
			$Objectives.is_email_open = $EmailScreenLevel1.is_email_open
		time = 0

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
	
