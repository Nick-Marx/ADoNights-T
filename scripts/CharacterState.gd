class_name CharacterState
extends StateBase


func _on_character_button_down():
	parent.state_changed.emit(parent.current_child_state, self)
