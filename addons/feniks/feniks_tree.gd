@tool
class_name FeniksTree
extends Control

@export var force_update_tree: bool:
	set(value):
		update_tree()
@export var source: String

func update_tree() -> void:
	print("Updating tree: ", name)
	FeniksTreeBuilder.build_tree(self, FeniksParser.parse(source))
