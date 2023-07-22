extends Node

@onready var player_sprite = $PlayerSprite
const level=preload("res://level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spin_hair_color_value_changed(value):
	Globals.hair_color=value
	player_sprite.hair_color=value
	pass # Replace with function body.


func _on_spin_hair_style_value_changed(value):
	Globals.hair_style=value
	player_sprite.hair_style=value
	pass # Replace with function body.


func _on_spin_box_top_value_changed(value):
	Globals.top_style=value
	player_sprite.top_style=value
	pass # Replace with function body.


func _on_spin_pant_value_changed(value):
	Globals.pant_style=value
	player_sprite.pant_style=value
	pass # Replace with function body.


func _on_spin_helmet_value_changed(value):
	Globals.helmet_style=value
	player_sprite.helmet_style=value
	pass # Replace with function body.


func _on_option_skin_item_selected(index):
	Globals.skin_color=index
	player_sprite.skin_color=index
	pass # Replace with function body.


func _on_check_box_mouth_toggled(button_pressed):
	Globals.has_mouth=button_pressed
	player_sprite.has_mouth=button_pressed
	pass # Replace with function body.


func _on_button_start_pressed():
	get_tree().change_scene_to_packed(level)

