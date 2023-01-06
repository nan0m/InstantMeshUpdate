# InstantMeshUpdate
 Instantly Update Meshes that you modified (in Blender)

IMPORTANT: READ LIMITATIONS CAREFULLY

Godot has a problem where when you update the file of a mesh in the background it won't update in editor, unless you open the file in a "New Inherited Scene".
This plugin is a workaround for that issue. It allows you to select certain nodes who should be updated if a change in their files is detected. 

## INSTRUCTIONS
1. Put the plugin in your addons folder
2. Activate it in the Plugins tab
3. Assign the Group "NodeUpdate" to all nodes that should be updated when their underlying file changes.
4. Profit

#LIMITATIONS
Right now the plugin works in such a way that the node to be updated is actually deleted and re-instanced at the same position. However, this means that as of now, if this node has any children those children will be deleted. Hence, I recommend you to only use it in certain contexts.
Also this plugin only works with .GLBs or .TSCNs as of now, at the beginning of the plugin is an array where you can add formats, and it should work for them too, however, I haven't tested that.
