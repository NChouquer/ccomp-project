extends Node

var network = NetworkedMultiplayerENet.new()
var port = 5000
var max_players = 100

func _ready():
	startServer()
	
func startServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	network.connect("peer_connected",self,"_Peer_Connected")
	network.connect("peer_disconnected",self,"_Peer_Disconnected")
	

func _Peer_Connected(player_id):
	print("User "+ str(player_id) + " connected")

func _Peer_Disconnected(player_id):
	print("User "+ str(player_id) + " disconnected")
	
	
remote func FetchSkillDamage(skill,requester):
	var player_id = get_tree().get_rpc_sender_id()
	var damage = DataImport.skill_data[skill].phys_damage
	rpc_id(player_id,"ReturnSkillDamage",damage,requester)
	print("Sending "+str(damage)+" of damage to "+str(player_id))
	
