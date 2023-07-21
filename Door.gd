extends StaticBody2D

@onready var sprite_2d = $Sprite2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D


@export var require_square=false
@export var require_pentagon=false
@export var require_octagon=false
@export var require_triangle=false
@export var require_4star=false
@export var require_5star=false
@export var require_diamond=false
@export var require_circle=false
@export var require_heart=false

var is_open:bool=false:
	get: return is_open
	set(v):
		if v:
			sprite_2d.region_rect.position.x=612
			sprite_2d.region_rect.position.y=17
		else:
			sprite_2d.region_rect.position.x=544
			sprite_2d.region_rect.position.y=0
		is_open=v
		set_collision_layer_value(1,not is_open)

func _ready():
	area_2d.body_entered.connect(body_enterd)
	area_2d.body_exited.connect(body_exited)

func body_enterd(body):
	if "can_drop" in body:
		body.can_drop=false


func body_exited(body):
	if "can_drop" in body:
		body.can_drop=true

func try_open(items:Dictionary):
	is_open=can_open(items)

func can_open(items:Dictionary)->bool:
	var required=[require_square,
			require_pentagon,
			require_octagon,
			require_triangle,
			require_4star,
			require_5star,
			require_diamond,
			require_circle,
			require_heart]
	for i in range(9):
		if required[i] != items.has(i):
			return false
	return true

func open():
	is_open=true

func close():
	is_open=false

signal show_requirements(requirement)
