extends CharacterBody3D


var target: CharacterBody3D

var speed: float = 4.0

var base_health: float = 100.0
var damage: float = 10.0
var attack_cooldown: float = 1.0
var cooldown_left: float = 0.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var ray_cast_3d: RayCast3D = $Head/RayCast3D

func _physics_process(delta: float) -> void:
	if target == null:
		return
	# Facing the target
	look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
	$Head.look_at(Vector3(target.global_position.x, target.head.global_position.y, target.global_position.z), Vector3.UP)
	
	if base_health <= 0:
		queue_free()
		print("enemy died")
	
	if cooldown_left > 0.0:
		cooldown_left -= delta
	var collider = ray_cast_3d.get_collider()
	if ray_cast_3d.is_colliding() and collider is CharacterBody3D:
		hit_target()
	
	
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Searching the target
	navigation_agent_3d.set_target_position(target.global_position)
	var next_position = navigation_agent_3d.get_next_path_position()
	velocity = (next_position - global_position).normalized() * speed
	
	move_and_slide()

func hit_target():
	#print(cooldown_left)
	if cooldown_left <= 0.0 and target.base_health > 0:
		cooldown_left = attack_cooldown
		target.base_health -= damage
	if target.base_health < 0:
		target.base_health = 0


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		target = body


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		target = null
