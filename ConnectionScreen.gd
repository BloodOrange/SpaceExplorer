extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/EditName.grab_focus()
	get_tree().connect("connected_to_server", self, "_on_connected")

func _on_connected():
	get_tree().change_scene("res://Spatial.tscn")

func _on_EditName_text_changed(new_text):
	var is_valid_text = new_text.empty()
	
	$CenterContainer/VBoxContainer/HBoxContainer/BtnCreate.disabled = is_valid_text
	$CenterContainer/VBoxContainer/HBoxContainer/BtnJoin.disabled = is_valid_text

func _on_BtnCreate_pressed():
	Network.create_server()
	
	if get_tree().get_network_peer():
		_on_connected()

func _on_BtnJoin_pressed():
	Network.join_server($CenterContainer/VBoxContainer/EditIp.text)
