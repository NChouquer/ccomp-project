extends Node

var chat_log = []
var max_log_size = 6

func _ready():
	pass


func ReceiveMessage(player_id,msg,timestamp):
	chat_log.append({"u":player_id,"m":msg,"t":timestamp})
	chat_log.sort_custom(self,"chatSort")
	if chat_log.size()> max_log_size:
		chat_log.pop_front()
		

func chatSort(a,b):
	return a["t"] < b["t"]
