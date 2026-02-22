extends Control


@onready var score_label: Label = $VBoxContainer/Score_Label
@onready var total_attempts_label: Label = $VBoxContainer/TotalAttempts_Label
@onready var longest_streak_label: Label = $VBoxContainer/LongestStreak_Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Score: " + str(GameManager.score)
	total_attempts_label.text = "Total Attempts: "+str(GameManager.totalDungeons_Accomplished)
	longest_streak_label.text = "Longest Streak: "+str(GameManager.longestStreak_final)
	
	GameManager.highestScore_Lifetime = GameManager.score
	GameManager.totalDungeonsPlayed_Lifetime += GameManager.totalDungeons_Accomplished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_button_pressed() -> void: # have to also include code that restarts game
	GameManager.score = 0
	GameManager.totalDungeons_Accomplished = 0
	GameManager.longestStreak_final = 0
	
	GameManager.dungeonsGLOBAL = 0 # resets the hints-mechanic
	GameManager.hintsUsed = 0 # resets the hints-mechanic
	
	get_tree().change_scene_to_file("res://Scenes/play_control.tscn")

func _on_main_menu_button_pressed() -> void:
	GameManager.score = 0
	GameManager.totalDungeons_Accomplished = 0
	GameManager.longestStreak_final = 0

	GameManager.dungeonsGLOBAL = 0 # resets the hints-mechanic
	GameManager.hintsUsed = 0 # resets the hints-mechanic
	
	
	get_tree().change_scene_to_file("res://Scenes/main_menu_control.tscn")
