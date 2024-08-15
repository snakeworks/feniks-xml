class_name FeniksParser

const NODE_NAME := "node_name"
const ATTRIBUTES := "attributes"
const CHILDREN := "children"

static func parse(source: String) -> Dictionary:
	var xml_parser = XMLParser.new()
	xml_parser.open(source)
	
	var root := {}
	var queue := []
	
	while xml_parser.read() != ERR_FILE_EOF:
		if xml_parser.get_node_type() == XMLParser.NODE_ELEMENT_END:
			var children := []
			var children_idxs := []
			for idx in range(len(queue)-1, -1, -1):
				if queue[idx][NODE_NAME] == xml_parser.get_node_name():
					queue[idx][CHILDREN] = children
					break
				children.append(queue[idx])
				children_idxs.append(idx)				
			for idx in range(len(children_idxs)):
				queue.remove_at(children_idxs[idx])
				
		var node_data := {}
		var attributes_dict := {}
		
		for idx in range(xml_parser.get_attribute_count()):
			attributes_dict[xml_parser.get_attribute_name(idx)] = xml_parser.get_attribute_value(idx)
		
		node_data[NODE_NAME] = xml_parser.get_node_name() 
		node_data[ATTRIBUTES] = attributes_dict 
		node_data[CHILDREN] = [{}]
		
		queue.append(node_data)
		
		if root == {}:
			root = node_data
			
	return root
