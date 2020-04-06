extends Node

const SERVER_PORT = 30100

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func create_server():
	var peer = NetworkedMultiplayerENet.new()
	
	if peer.create_server(SERVER_PORT, 5) != OK:
		print("Erreur lors de la création du serveur")
		return
	
	print("Création du serveur...")
	
	get_tree().set_network_peer(peer)

func join_server(address_ip):
	var peer = NetworkedMultiplayerENet.new()
	
	if peer.create_client(address_ip, SERVER_PORT) != OK:
		print("Impossible de joindre le serveur")
		return
	
	print("Connexion au serveur...")
	
	get_tree().set_network_peer(peer)


func _player_connected(id):
	print("Nouveau client " + str(id))

func _player_disconnected(id):
	print("Déconnexion du client")

func _connected_ok():
	print("Connection réussite")

func _server_disconnected():
	print("serveur déconnecté")

func _connected_fail():
	print("Impossible de se connecter")
