extends Control

@onready var back_button: Button = $VBoxContainer/BackButton
@onready var start_button: Button = $VBoxContainer/StartButton
@onready var hints_button: Button = $VBoxContainer/HintsButton
@onready var display_label: Label = $DisplayStuff_Node/Display_Label
@onready var input_panel: Panel = $InputStuff_Node/Input_Panel
@onready var input_panel_correct: Panel = $InputStuff_Node/Input_Panel_Correct
@onready var input_panel_wrong: Panel = $InputStuff_Node/Input_Panel_Wrong
@onready var input_line_edit: LineEdit = $InputStuff_Node/Input_LineEdit
@onready var dungeons_passed_label: Label = $DungeonsPassed_Label
@onready var timer_label: Label = $TimerLabel
@onready var display_shut_timer_timer: Timer = $Timer_Node/DisplayShutTimer_Timer
@onready var input_border_color_timer: Timer = $Timer_Node/InputBorderColor_Timer

# Script vars

var GameTimer : float = 0.0 # for the remaining two game modes, the scripting is almost similar,
# like they both use the same type of 'timing' system unlike the first game mode
var GameTimerBool : bool = false # dont think i need this - because 'gameState' serves its purpose
var gameState : bool = false # used to keep track of the (two) game's state; becoz we need a way
# to 'stop' the timing system for the 'hints' button

var dungeonsPassed : int = 0 # tracks number of dungeons beat at START of game and for rest of game
# the above works at the start of the game and in-between the game when incorrect inputs occur
var dP_and_nC_Checker : bool = false # used to 'switch' off the  'sd_timer' if statement in the _process() to avoid running that every 5 dungeons
# dP = dungeonsPassed; nC = 

var hintsOn = false # boolValue checking if the 'hints' button has been triggered or not
var recentTempTime = 0.0 # var that stores the most recent 'timer' node time - used for when game
# is momentarily stopped becase the hints is switched 'on'


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_panel.visible = false
	input_line_edit.visible = false
	
	timer_label.text = "Timer: %d" % (GameTimer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if gameState:
		GameTimer += delta # starts var 'GameTimer' timer / delta is elapsed time since start - thus serves as 'counting'
		#GameTimerBool = true # makes the boolVar that keeps track if timer is on or not, be on
		##display_label.text	
		
		if hintsOn:
			timer_label.text = "Timer: " + str(int(GameTimer)) + " - Slaying Halted!"
		else:
			timer_label.text = "Timer: %d" % (GameTimer) 
		# timer.time_left + 1 --> because the countdown from 15 to 0 is 16sec and not 15sec
		
		# where input happens
		input_line_edit.keep_editing_on_text_submit = true
		
		# the following is to ensure that the placeHolderText is at font_size = 50
		# and the line_edit.text is at font_size = 100
		if input_line_edit.text != "":
			input_line_edit.add_theme_font_size_override("font_size", 100)
		else: 
			input_line_edit.add_theme_font_size_override("font_size", 50)
		# the above ensures that till the game runs, the LineEdit works
		# as in it doesn't lose focus of the node, when 'ENTER' is pressed


# Custom Functions:




# Signals:

func _on_back_button_pressed() -> void:
	GameManager.dungeonsGLOBAL = 0 # resets the hints-mechanic
	GameManager.hintsUsed = 0 # resets the hints-mechanic
	get_tree().change_scene_to_file("res://Scenes/play_control.tscn")


func _on_start_button_pressed() -> void:
	
	gameState = true # shows that gameplay has started
	
	
	display_shut_timer_timer.start()
	
	input_panel.visible = true
	input_line_edit.visible = true
	input_line_edit.grab_focus() # ensure that the LineEdit is in 'focus' and player can 
	# freely type than refocusing it, upon pressing the start button
	
	GameManager.gameStart(display_label, dungeonsPassed) # initializes the appropriate variables and arrays to display
	


func _on_input_line_edit_text_submitted(new_text: String) -> void:
		# after text submitted (i.e. after ENTER pressed) we check first before clearing
	
	if input_line_edit.text == "":
		input_line_edit.placeholder_text = "Please input a 'solution'"

	elif GameManager.correctInput_Checker(input_line_edit, dungeonsPassed):
		display_shut_timer_timer.wait_time = 1.5
		display_label.visible = true
		input_panel_correct.visible = true # green bordered box made visible
		
		dungeonsPassed += 1 # will be used in the deductible_Multiplier
		dungeons_passed_label.text = "Dungeons: " + str(dungeonsPassed)
		GameManager.score += 10
		
		# dont need the following lines of code about 'timer.stop()' or 'timer.start()', 
		# because the timer is an incr-timer
		
		display_shut_timer_timer.start() # because i did this: display_shut_timer_timer.one_shot = true
		GameManager.gameStart(display_label, dungeonsPassed)

	else:
		input_panel_wrong.visible = true # red bordered box made visible
		
		# dont require code that causes a deduction in time because the other 2 
		# game modes are with timers that incr and not decr like the first game mode

	GameManager.totalDungeons_Accomplished += 1
	input_line_edit.clear() # this erases the Input_LineEdit's text
	
	# timer code to switch the border color between the wrong and right after 0.5s
	input_border_color_timer.start()
	# disabling of the input box border color is down in the next signal


func _on_input_border_color_timer_timeout() -> void:
	input_panel_correct.visible = false
	input_panel_wrong.visible = false
	input_panel.visible = true


func _on_display_shut_timer_timer_timeout() -> void:
	display_label.visible = false
	
	# re-focuses the input_line_edit node
	input_line_edit.grab_focus() # regrabs the focus of the input_line_edit
	input_line_edit.keep_editing_on_text_submit = true
	
	if hintsOn:
		gameState = true # ensuring that we switch off the hints and shut the display
		hintsOn = false
		

func _on_hints_button_pressed() -> void:
	hintsOn = true
	GameManager.hintsUsed += 1
	
	# put the for loop with the deduction stuff in the GameManager
	GameManager.hintsDeduc_mechanic(GameManager.tier_checker(dungeonsPassed))
	# whats happening is that we call the hintsDeduc func from the GameManager_Singleton
	# and then we call the tier_checker from the GameManager as well, passing in all the successful 
	# dungeons the player has passed presently -> dungeonsPassed
	GameManager.hintsUsed_bool = true # flips a switch representing a hint has been used, will switch off
	GameManager.hints_Zero = false # indicates that player has selected a hint and there hintsUsed != 0

	#recentTempTime = tempTime # getting the most recent time before stopping the 'timer' node
	gameState = false # a switch to act as the equivalent of 'timer.stop()'
	display_shut_timer_timer.wait_time = 1.5 
	display_label.visible = true
	display_shut_timer_timer.start()
	

# to test if the switching of shapes works based on the dungeons accumulated
@onready var cheat_test_button: Button = $"../Cheat_TestButton"
func _on_cheat_test_button_pressed() -> void:
	if dungeonsPassed == 0:
		dungeonsPassed = 5
	elif dungeonsPassed == 5:
		dungeonsPassed = 10
	elif dungeonsPassed == 10:
		dungeonsPassed = 15
	elif dungeonsPassed == 15:
		dungeonsPassed = 20
	elif dungeonsPassed == 20:
		dungeonsPassed = 30
	elif dungeonsPassed == 30:
		dungeonsPassed = 45
	elif dungeonsPassed == 45:
		dungeonsPassed = 50
	elif dungeonsPassed == 50:
		dungeonsPassed = 60
	
	cheat_test_button.text = "Cheat: " + str(dungeonsPassed)
	GameManager.gameStart(display_label, dungeonsPassed)
