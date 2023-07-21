@tool
extends Node2D
const player_ts=preload("res://roguelikeChar_transparent.png")

@export_enum("light:0","middle:1","dark:2","green:3")
var skin_color:int:
	get:
		return skin_color
	set(v):
		skin_color=v
		queue_redraw()

@export
var has_mouth:bool:
	get:
		return has_mouth
	set(v):
		has_mouth=v
		queue_redraw()


@export_range(0,20)
var pant_style:int:
	get:
		return pant_style
	set(v):
		pant_style=v
		queue_redraw()

@export_range(0,120)
var top_style:int:
	get:
		return top_style
	set(v):
		top_style=v
		queue_redraw()

@export_range(0,4)
var hair_color:int:
	get:
		return hair_color
	set(v):
		hair_color=v
		queue_redraw()

@export_range(0,15)
var hair_style:int:
	get:
		return hair_style
	set(v):
		hair_style=v
		queue_redraw()

@export_range(0,35)
var helmet_style:int:
	get:
		return helmet_style
	set(v):
		helmet_style=v
		queue_redraw()

func _ready():
	queue_redraw()

func _draw():
	#skin color
	draw_tile(Vector2(int(has_mouth),skin_color))
	#pants
	draw_tile(Vector2(3,0)+Vector2(pant_style%2,pant_style/2))
	#top
	draw_tile(Vector2(6,0)+Vector2(top_style%12,top_style/12))
	#hairs
	var hairs_location=Vector2(0,0)
	hairs_location.x=4*(hair_color%2)+hair_style%4+19
	hairs_location.y=4*(hair_color/2)+hair_style/4
	draw_tile(hairs_location)
	#helmet
	draw_tile(Vector2(28,0)+Vector2(helmet_style%4,helmet_style/4))

func draw_tile(tile_position:Vector2):
	draw_texture_rect_region(player_ts,Rect2(0,0,16,16),Rect2(tile_position*16+tile_position,Vector2(16,16)))
