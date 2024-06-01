extends CanvasLayer

func changeScene(new_scene_path : String, lvl_number: String):
	$ColorRect/Label.text = "Level " + lvl_number
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file(new_scene_path)
	$AnimationPlayer.play("dissapear")
	
	
	
	
