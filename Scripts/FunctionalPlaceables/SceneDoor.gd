extends Area2D

export (String) var nextRoomPath

func _on_SceneDoor_body_entered(body):
	if body.name == "Player":
		GlobalVariables.lastRoom = int(get_parent().get_parent().name)
		get_tree().change_scene(nextRoomPath)
