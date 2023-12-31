extends CharacterBody2D

@onready var player_sprite = $PlayerSprite

var inventory={}

signal item_added(player,item_type)
signal item_removed(player,item_type)

var can_drop=true

var cap=1

var carry_count=0

signal cap_changed(new_cap)

func _ready():
	player_sprite.hair_color=Globals.hair_color

	player_sprite.hair_style=Globals.hair_style

	player_sprite.top_style=Globals.top_style

	player_sprite.pant_style=Globals.pant_style

	player_sprite.helmet_style=Globals.helmet_style

	player_sprite.skin_color=Globals.skin_color

	player_sprite.has_mouth=Globals.has_mouth

func _physics_process(_delta):
	velocity=Input.get_vector("left","right","up","down")*128
	move_and_slide()


func reward(rewarder):
	if inventory.has(rewarder.type) or carry_count>=cap:
		return
	else:
		inventory[rewarder.type]=true
		item_added.emit(self,rewarder.type)
		rewarder.queue_free()
		carry_count+=1

func drop(item_type):
	if can_drop and inventory.has(item_type):
		inventory.erase(item_type)
		item_removed.emit(self,item_type)
		carry_count-=1

func increase_cap():
	cap=cap+1
	cap_changed.emit(cap)
