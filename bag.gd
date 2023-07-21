extends Area2D


func _ready():
	body_entered.connect(func(body):
			if body.has_method("increase_cap"):
				body.increase_cap()
				queue_free()
			)

