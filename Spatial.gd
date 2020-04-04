extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const SERVER_PORT = 30100
const SERVER_IP = "192.168.1.26"

const SERVER_MODE = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if SERVER_MODE:
		Network.create_server(SERVER_PORT)
	else:
		Network.join_server(SERVER_IP, SERVER_PORT)
	
	if SERVER_MODE == false:
		$BattleShip.change_seat(2)
