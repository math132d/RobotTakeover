extends Node



func _on_Robot_item_drop(item_scene, pos):
	var drop = item_scene.instance()
	drop.init(pos, pos.y+10)
	$YSort.add_child(drop)
