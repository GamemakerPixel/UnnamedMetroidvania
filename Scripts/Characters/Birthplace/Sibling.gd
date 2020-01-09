extends StaticBody2D

export (int) var abilityToGrant
export (PoolStringArray) var dialog
var runningDialog = false
var onLine = 0

func _process(delta):
	if runningDialog:
		if Input.is_action_just_pressed("ui_accept"):
			onLine += 1
			runDialog()

func _on_dialogQue_body_entered(body):
	if body.name == "Player":
		runDialog()

func runDialog():
	get_parent().get_node("Player").printDialog(dialog)
	get_parent().get_node("Player").unlockAbility(abilityToGrant)
