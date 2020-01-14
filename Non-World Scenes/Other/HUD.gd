extends CanvasLayer

var runningDialog = false
var dialogSize
var currentDialogLine = 0
var dialog
var speaker

func setDialog(dialog_, speaker_ = "???"):
	dialog = dialog_
	speaker = speaker_
	runningDialog = true
	dialogSize = dialog.size() - 1
	if dialogSize >= currentDialogLine:
		$DialogBox.show()
		$DialogBox/Descale/Speaker.text = speaker
		$DialogBox/Descale/Dialouge.text = dialog[currentDialogLine]
	else:
		runningDialog = false
		$DialogBox.hide()
		$DialogBox/Descale/Dialouge.text = " "
		$DialogBox/Descale/Speaker.text = " "

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		currentDialogLine += 1
		_setDialog(dialog, speaker)
