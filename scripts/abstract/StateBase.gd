@abstract
class_name StateBase
extends Node


var parent: StateMachine
var childSM: StateMachine


func _ready() -> void:
	if get_parent() == StateMachine:
		parent = get_parent()
	
	if get_children():
		for child in get_children():
			if child == StateMachine:
				childSM = child


func _process(_delta) -> void:
	pass


func enter() -> void:
	self.visible = true
	
	if childSM:
		childSM.is_active = true


func exit() -> void:
	self.visible = false
	
	if childSM:
		childSM.is_active = false


func update(_delta: float) -> void:
	pass
