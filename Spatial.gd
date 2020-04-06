extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().is_network_server() == false:
		$BattleShip.change_seat(2)
