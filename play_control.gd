extends Control




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_easy_button_pressed() -> void: # easy_button = dungeonSlayers
	GameManager.currentPlayState = GameManager.playState[0] # playState = "easy"
	get_tree().change_scene_to_file("res://Scenes/play_dungeon_slayers_control.tscn")
	
	
func _on_medium_button_pressed() -> void: # medium_button = vanillaSpeedrunners
	GameManager.currentPlayState = GameManager.playState[1] # playState = "medium"
	get_tree().change_scene_to_file("res://Scenes/play_vanilla_speedrunners_control.tscn")
	

func _on_hard_button_pressed() -> void: # hard_button = sequencesSpeedrunners
	GameManager.currentPlayState = GameManager.playState[2] # playState = "hard"
	get_tree().change_scene_to_file("res://Scenes/play_sequences_speedrunners_control.tscn")
	

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu_control.tscn")
