extends Node
@onready var item_list = $CanvasLayer/HBoxContainer/ItemList
@onready var player = $TileMap/Player
@onready var tile_map = $TileMap
@onready var label = $CanvasLayer/HBoxContainer/Label

const congrat=preload("res://congratulations.tscn")

const sprites=[preload("res://diamonds/tileGrey_04.png"), preload("res://diamonds/tileGrey_05.png"), preload("res://diamonds/tileGrey_06.png"), preload("res://diamonds/tileGrey_07.png"), preload("res://diamonds/tileGrey_08.png"), preload("res://diamonds/tileGrey_09.png"), preload("res://diamonds/tileGrey_10.png"), preload("res://diamonds/tileGrey_11.png"), preload("res://diamonds/tileGrey_12.png")]
const diamonds=[
	preload("res://diamonds/diamond_square.tscn"),
	preload("res://diamonds/diamond_pentagon.tscn"),
	preload("res://diamonds/diamond_octagon.tscn"),
	preload("res://diamonds/diamond_triangle.tscn"),
	preload("res://diamonds/diamond_4star.tscn"),
	preload("res://diamonds/diamond_5star.tscn"),
	preload("res://diamonds/diamond_diamond.tscn"),
	preload("res://diamonds/diamond_circle.tscn"),
	preload("res://diamonds/diamond_heart.tscn")
	]

func _ready():
	player.item_added.connect(player_item_added)
	player.item_removed.connect(player_item_removed)
	player.cap_changed.connect(func(new_cap):
			label.text="Cap "+str(new_cap)
			)
	update_doors()

func update_doors():
	for d in get_tree().get_nodes_in_group("doors"):
		d.try_open(player.inventory)

func _process(_delta):
	if Input.is_action_just_pressed("next_item"):
		item_list.grab_focus()
		if item_list.is_anything_selected():
			var sel_idx=item_list.get_selected_items()[0]
			item_list.select(sel_idx+1)
		else:
			item_list.select(0)
	if Input.is_action_just_pressed("previous_item"):
		item_list.grab_focus()
		if item_list.is_anything_selected():
			var sel_idx=item_list.get_selected_items()[0]
			item_list.select(sel_idx-1)
		else:
			item_list.select(item_list.item_count-1)
	if Input.is_action_just_pressed("drop") and item_list.is_anything_selected():
		var sel_idx=item_list.get_selected_items()[0]
		var item_type=item_list.get_item_metadata(sel_idx)
		if player.drop(item_type):
			item_list.remove_item(sel_idx)

func player_item_added(_player,item_type):
	var item_idx=item_list.add_icon_item(sprites[item_type])
	item_list.set_item_metadata(item_idx,item_type)
	update_doors()

func player_item_removed(_player,item_type):
	remove_first_item_of_type(item_type)
	var the_diamond=diamonds[item_type].instantiate()
	the_diamond.can_collect=false
	tile_map.add_child(the_diamond)
	the_diamond.position=player.position
	update_doors()

func remove_first_item_of_type(type):
	for i in item_list.item_count:
		if item_list.get_item_metadata(i)==type:
			item_list.remove_item(i)
			return

func show_door_requirements():
	pass


func _on_area_2d_2_body_entered(body):
	if body.has_method("reward"):
		get_tree().change_scene_to_packed(congrat)

