extends Node
class_name StateMachine

@export var initial_state: States

var current_state: States
var entity: CharacterBody3D
var animation: AnimationPlayer
var previous_speed: float

func _ready():
	entity = get_parent() as CharacterBody3D
	animation = entity.animation

	for child in get_children():
		child.machine = self
		child.entity = entity
		child.animation = animation

	change_state(initial_state)

func _physics_process(delta):
	#print(previous_speed)
	if current_state:
		current_state.update()
	#print(current_state)
	Global.debug_panel.add_property("Current state", current_state, 2)

func change_state(new_state: States):
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
