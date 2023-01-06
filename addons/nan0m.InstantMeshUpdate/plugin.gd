tool
extends EditorPlugin

var accepted_file_types = ["glb", ".tscn"] #you can add other formats, I just didn't test them


var f = File.new()
var edi = get_editor_interface()
var edfs = get_editor_interface().get_resource_filesystem()
var modif_dict = {}

func _enter_tree() -> void:
	pass

func _process(delta: float) -> void:
	var edi = get_editor_interface()
	var r = edi.get_edited_scene_root()
	if r == null:
		return
		
	for n in r.get_tree().get_nodes_in_group("NodeUpdate"):
		var filename = n.get_filename()
		if not filename.get_extension() in accepted_file_types:
			return
			
		if not n in modif_dict:
			var mod_time = f.get_modified_time(filename)
			modif_dict[n] = mod_time
		else:
			var modif = f.get_modified_time(filename)
			if modif > modif_dict[n]:
				modif_dict[n] = modif
				var parent_node = n.get_parent()
				var pos_in_parent = n.get_position_in_parent()
				n.queue_free()
				edfs.scan()
				edfs.scan_sources()
				edfs.update_file(filename)
				yield(get_tree().create_timer(1.0), "timeout")
				var new = load(filename).instance()
				new.add_to_group("NodeUpdate", true)
				parent_node.add_child(new)
				parent_node.move_child(new, pos_in_parent)
				new.set_owner(edi.get_edited_scene_root())
			else:
				continue
			pass

func _exit_tree() -> void:
	pass
