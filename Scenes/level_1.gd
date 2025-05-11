extends Node2D

var time = 0

func _ready():
	fill_objectives()
	pass
	

func _process (delta):
	time += delta
	if time > 0.25:
		print($Objectives.button_pressed)
		if $Objectives.button_pressed:
			$EmailScreenLevel1.open_email()
			$Objectives.button_pressed = false
			$Objectives.is_email_open = $EmailScreenLevel1.is_email_open
		time = 0

func fill_objectives():
	$Objectives/LabelContact.text = $EmailScreenLevel1.email_name
	pass
	
