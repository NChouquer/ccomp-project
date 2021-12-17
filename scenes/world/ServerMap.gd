extends Node2D

var projectile = preload("res://scenes/world/ServerProjectile.tscn")
var monster = preload("res://scenes/world/ServerMonster.tscn")

func _ready():
	pass
	
func SpawnAttack(start_pos,direction,skill,player_id):
	var projectile_instance = projectile.instance()
	projectile_instance.position = start_pos
	projectile_instance.prepare_projectile(direction,skill,player_id)
	add_child(projectile_instance)


func SpawnEnemy(enemy_id,location):
	var enemy_instance = monster.instance()
	enemy_instance.position = location
	enemy_instance.name = str(enemy_id)
	get_node("Characters/Enemies").add_child(enemy_instance,true)
