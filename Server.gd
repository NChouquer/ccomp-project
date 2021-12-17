extends Node

var network = NetworkedMultiplayerENet.new()
var port = 5000
var max_players = 100
var player_state_collection = {}


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
	rpc_id(0,"SpawnNewPlayer",player_id,Vector2(64,256))

func _Peer_Disconnected(player_id):
	print("User "+ str(player_id) + " disconnected")
	player_state_collection.erase(player_id)
	rpc_id(0,"DespawnPlayer",player_id)

remote func CreateAccount(username,password):
	var response_code
	var response_info = {}
	var player_id = get_tree().get_rpc_sender_id()
	if DataImport.user_data.has(username) ==false:
		DataImport.newAccount(username,password)
		response_info = DataImport.getUserInfo(username)
		response_code = 0
	else:
		response_code = 1
		
	
	rpc_id(player_id,"CreateAccountResponse",response_code,response_info)
	
remote func LogIn(username,password):
	var response_code
	var response_info = {}
	var player_id = get_tree().get_rpc_sender_id()
	if DataImport.user_data.has(username) ==false:
		response_code = -1
	else:
		if DataImport.user_data.get(username)["password"]==password:
			response_info = DataImport.getUserInfo(username)
			response_code = 0
		else:
			response_code = 1
	
	rpc_id(player_id,"LogInResponse",response_code,response_info)
	
remote func ReceivePlayerState(player_state):
	var player_id = get_tree().get_rpc_sender_id()
	if player_state_collection.has(player_id):
		if player_state_collection[player_id]["T"]<player_state["T"]:
			player_state_collection[player_id] = player_state
	else:
		player_state_collection[player_id] = player_state
			
func SendWorldState(world_state):
	rpc_unreliable_id(0,"ReceiveWorldState",world_state)
	
	
remote func ReceiveChatMessage(message,timestamp):
	var player_id = get_tree().get_rpc_sender_id()
	print(message)
	get_node("Chat").ReceiveMessage(player_id,message,timestamp)
	
remote func Attack(start_pos,direction,skill):
	var player_id = get_tree().get_rpc_sender_id()
	get_node("WorldMap").SpawnAttack(start_pos,direction,skill,player_id)
	#rpc_id(0,"ReceiveAttack",start_pos,direction,skill)
