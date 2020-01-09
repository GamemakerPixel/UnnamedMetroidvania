extends CanvasLayer

var runningDialog = false
var dialogSize
var currentDialogLine = 0
var dialog
var speaker

func _setDialouge(dialog_, speaker_):
	dialog = dialog_
	speaker = speaker_
	runningDialog = true
	dialogSize = dialog.size() - 1
	if dialogSize >= currentDialogLine:
		$DialogBox/Descale/Dialouge.text = dialog[currentDialogLine]
	else:
		$DialogBox.hide()
		$DialogBox/Descale/Dialouge.text = " "
		$DialogBox/Descale/Speaker.text = " "

func _process(delta):
	pass
