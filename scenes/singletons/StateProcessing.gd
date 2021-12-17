extends Node

var world_state
var clock_sync_counter = 0

func _physics_process(delta):
	clock_sync_counter += 1
	if clock_sync_counter == 3:
		clock_sync_counter = 0
		if not get_parent().player_state_collection.empty():
			world_state = get_parent().player_state_collection.duplicate(true)
			for player in world_state.keys():
				world_state[player].erase("T")
			world_state["T"] = OS.get_system_time_msecs()
			world_state["Enemies"] = get_node("../Map").enemy_list
			var chat_state = get_parent().get_node("Chat").chat_log.duplicate(true)
			for message in chat_state:
				message.erase("t")
			world_state["Chat"] = chat_state
			get_parent().SendWorldState(world_state)
			
