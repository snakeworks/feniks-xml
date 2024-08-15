@tool
class_name FeniksTree
extends Control

@export var force_update_tree: bool:
	set(value):
		update_tree()
@export var source: String

func update_tree() -> void:
	var parsed_tree := FeniksParser.parse(source)
	FeniksTreeBuilder.build_tree(self, parsed_tree)
	FeniksParser.print_tree(parsed_tree)
