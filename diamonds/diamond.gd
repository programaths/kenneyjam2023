extends Area2D



@export_enum("Square:0","Pentagon:1","Octagon:2","Triangle:3","FourStar:4","FiveStar:5","Diamond:6","Circle:7","Heart:8") var type=1
var can_collect=true

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(body_entered_handler)
	body_exited.connect(body_exited_handler)


func body_entered_handler(body):
	if body.has_method("reward") and can_collect:
		body.reward(self)
		can_collect=false

func body_exited_handler(body):
	if body.has_method("reward"):
		can_collect=true

