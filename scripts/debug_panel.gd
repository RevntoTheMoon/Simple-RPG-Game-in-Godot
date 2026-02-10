extends Control

const ENEMY_1 : PackedScene = preload("res://scenes/enemy_prototype_1.tscn")

var property
var frame_per_second : String
var context

@onready var property_container = %VBoxContainer
@onready var panel = $Panel


func _ready() -> void:
	Global.debug_panel = self
	panel.visible = false
	context = $Context

func _process(delta: float) -> void:
	frame_per_second = str(Engine.get_frames_per_second())
	Global.debug_panel.add_property("FPS", frame_per_second, 0)
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	#print(panel.visible)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_panel"):
		panel.visible = !panel.visible 
		context.visible = !context.visible
	if panel.visible == true and event.is_action_pressed("spawn_entities"):
		print("clicked")
		var _enemy = ENEMY_1.instantiate()
		get_tree().current_scene.get_node("NavigationRegion3D").add_child(_enemy)
		#_enemy.global_position = global_position	

func add_property(title: String, value, order):
	var target
	target = property_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)
