class_name FeniksTreeBuilder

static func build_tree(node: FeniksTree, root: Dictionary) -> void:
	for idx in range(node.get_child_count()):
		node.get_child(idx).free()
		
	_fetch_tree_children(node, root)
	
static func _fetch_tree_children(parent: Node, node_tree: Dictionary) -> void:
	if node_tree == {}:
		return
		
	parent = _create_node(parent, node_tree[FeniksParser.NODE_NAME], node_tree[FeniksParser.ATTRIBUTES])
	for idx in range(len(node_tree[FeniksParser.CHILDREN])):
		_fetch_tree_children(parent, node_tree[FeniksParser.CHILDREN][idx])
	
static func _create_node(parent: Node, node_name: String, attributes: Dictionary) -> Node:
	var node = ClassDB.instantiate(node_name)
	
	parent.add_child(node)
	node.set_owner(EditorInterface.get_edited_scene_root())
	
	for key in attributes:
		node.set(key, attributes[key])

	return node
