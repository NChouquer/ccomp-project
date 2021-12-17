extends Node

var skill_data
var enemy_data
var user_data

func _ready():
	var skill_data_file = File.new()
	skill_data_file.open("res://Data/skill_data - Sheet1.json", File.READ)
	var skill_data_json = JSON.parse(skill_data_file.get_as_text())
	skill_data = skill_data_json.result
	
	var enemy_data_file = File.new()
	enemy_data_file.open("res://Data/enemy_data.json", File.READ)
	var enemy_data_json = JSON.parse(enemy_data_file.get_as_text())
	enemy_data = enemy_data_json.result
	
	var user_data_file = File.new()
	user_data_file.open("res://Data/user_data.json", File.READ)
	var user_data_json = JSON.parse(user_data_file.get_as_text())
	user_data = user_data_json.result
	

func save_user_data():
	var f = File.new()
	f.open("res://Data/user_data.json", File.WRITE)
	f.store_string(JSON.print(user_data, "  ", true))
	f.close()
	
func save_player_state(userinfo):
	var username = userinfo["U"]
	user_data[username]["pos_x"] = userinfo["P"].x
	user_data[username]["pos_y"] = userinfo["P"].y
	save_user_data()

func newAccount(username,password):
	user_data[username] = {"username":username,"password":password,"pos_x":64,"pos_y":256}

func getUserInfo(username):
	return {"u":user_data[username]["username"],"x":user_data[username]["pos_x"],"y":user_data[username]["pos_y"]}
