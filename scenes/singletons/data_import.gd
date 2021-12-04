extends Node

var skill_data

func _ready():
	var skill_data_file = File.new()
	skill_data_file.open("res://Data/skill_data - Sheet1.json", File.READ)
	var skill_data_json = JSON.parse(skill_data_file.get_as_text())
	skill_data = skill_data_json.result
