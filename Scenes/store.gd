extends Node2D

var tabs = []

func _process (delta):
	#if not tabs:
		#if $Items.isReady:
			#tabs = $Items.item_general_categories
			##print("store.gd: ", tabs)
	pass


func _ready():
	tabs = $Items.item_general_categories
	print ("store.gd", tabs)
	pass
