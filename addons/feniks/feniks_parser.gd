class_name FeniksParser

const NODE_NAME := "node_name"
const ATTRIBUTES := "attributes"
const CHILDREN := "children"

static func parse(source: String) -> Dictionary:
	var xml_parser = XMLParser.new()

	var xml_as_string := FileAccess.get_file_as_string(source).strip_edges().replace("\t", "")
	xml_parser.open_buffer(xml_as_string.to_utf8_buffer())

	var root := {}
	var queue := []

	while xml_parser.read() != ERR_FILE_EOF:
		if xml_parser.get_node_type() == XMLParser.NODE_ELEMENT_END:
			var children := []
			var children_idxs := []
			for idx in range(len(queue)-1, -1, -1):
				if queue[idx][NODE_NAME] == xml_parser.get_node_name():
					children.reverse()
					queue[idx][CHILDREN] = children
					break
				children.append(queue[idx])
				children_idxs.append(idx)
			for idx in range(len(children_idxs)):
				queue.remove_at(children_idxs[idx])
			continue
				
		var node_data := {}
		var attributes_dict := {}
		
		for idx in range(xml_parser.get_attribute_count()):
			attributes_dict[xml_parser.get_attribute_name(idx)] = xml_parser.get_attribute_value(idx)
		
		node_data[NODE_NAME] = xml_parser.get_node_name() 
		node_data[ATTRIBUTES] = attributes_dict 
		node_data[CHILDREN] = []
		
		queue.append(node_data)
		
		if root == {}:
			root = node_data
	
	return root

static func print_tree(node_tree: Dictionary, indent_level: int = 0) -> void:
	var spaces: String
	for idx in range(indent_level): spaces += " "
	print(spaces + ("" if indent_level == 0 else "|_") + node_tree[NODE_NAME])
	for idx in range(len(node_tree[CHILDREN])):
		print_tree(node_tree[CHILDREN][idx], indent_level+1)

