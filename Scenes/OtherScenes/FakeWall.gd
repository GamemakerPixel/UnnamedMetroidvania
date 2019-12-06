extends Area2D

export (String) var facing

func _ready():
	get_node(facing).show()
	for template in get_children():
		if not template.visible:
			template.queue_free()

func destroy():
	queue_free()


