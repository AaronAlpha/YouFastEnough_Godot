extends Control

@onready var surpassed_levels_label: Label = $SurpassedLevels_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Highest Surpassed Levels: 0
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/play_control.tscn")

func _on_leaderboard_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/leaderboards_control.tscn")

func _on_stats_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/stats_control.tscn")

func _on_music_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/music_control.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
