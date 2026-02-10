class_name StateMachine
extends StateBase


@export var initial_child_state: StateBase

var current_child_state: StateBase
#var parent: State
var child_states: Dictionary = {}
var is_active: bool = false


func _ready() -> void:
	find_children_()
	enter_initial_state()

	Signals.state_changed.connect(on_child_transition)

	if get_parent() == StateBase:
		parent = get_parent()
	
	if !parent:
		self.is_active = true


func _process(_delta: float) -> void:
	if current_child_state:
		current_child_state.update(_delta)
		
	if !self.is_active:
		for child in child_states:
			child.exit()


func find_children_() -> void:
	if get_children().is_empty():
		return

	for child in get_children():
		if child is StateBase:
			child_states[child.name.to_lower()] = child
			

func enter_initial_state() -> void:
	if initial_child_state:
		initial_child_state.enter()
		
	current_child_state = initial_child_state


func on_child_transition(previous, new) -> void:
	if previous != current_child_state:
		return
	
	var new_state = child_states.get(new.to_lower())
	if !new_state:
		return
	
	if current_child_state:
		current_child_state.exit()
	
	new_state.enter()
	
	current_child_state = new_state
