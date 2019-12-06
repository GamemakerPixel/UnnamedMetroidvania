extends StaticBody2D

export (int) var abilityToGrant
export (PoolStringArray) var dialouge

func _on_DialougeQue_body_entered(body):
	if body.name == "Player":
		runDialouge()

func runDialouge():
	var lines = dialouge.size()
	var line = 1
	for line in dialouge:
		get_parent().get_node("Player").printDialouge(line)
	get_parent().get_node("Player").unlockAbility(abilityToGrant)
