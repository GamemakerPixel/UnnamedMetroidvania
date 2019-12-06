extends Area2D

var colliding_bodies = []

func _on_body_entered(body):
	colliding_bodies.append(body)

func _on_body_exited(body):
	colliding_bodies.remove(colliding_bodies.find(body))
