extends RigidBody2D

var projectile_speed = 400
var life_time = 1
var skill = "basic_attack"
var player_id

func _ready():
	SelfDestruct()

func prepare_projectile(source_direction,skl, ply_id):
	rotation = rad2deg(source_direction.angle())
	skill = skl
	player_id = ply_id
	apply_impulse(Vector2(),Vector2(projectile_speed,0).rotated(rotation))
	
	
func SelfDestruct():
	yield(get_tree().create_timer(life_time),"timeout")
	queue_free()


func _on_Projectile_body_entered(body):
	get_node("CollisionPolygon2D").set_deferred("disabled",true)
	if body.is_in_group("Enemies"):
		print("hit")
		get_parent().get_parent().get_node("Map").NPCHit(int(body.get_name()),skill)
	self.hide()
