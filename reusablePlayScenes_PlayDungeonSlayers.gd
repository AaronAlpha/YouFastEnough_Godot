extends Control

@onready var display_label: Label = $DisplayStuff_Node/Display_Label
@onready var input_line_edit: LineEdit = $InputStuff_Node/Input_LineEdit
@onready var input_node: Node = $Input_Node
@onready var input_panel: Panel = $InputStuff_Node/Input_Panel
@onready var input_panel_correct: Panel = $InputStuff_Node/Input_Panel_Correct
@onready var input_panel_wrong: Panel = $InputStuff_Node/Input_Panel_Wrong
@onready var dungeons_passed_label: Label = $DungeonsPassed_Label
@onready var timer_label: Label = $TimerLabel
@onready var display_shut_timer_timer: Timer = $Timer_Node/DisplayShutTimer_Timer
@onready var input_border_color_timer: Timer = $Timer_Node/InputBorderColor_Timer

@onready var timer: Timer = $Timer # added from respective Game-Play-Scenes
@onready var sd_timer: Timer = $SD_Timer # added from PlayDungeonSlayers_Control scene


# ---------------------------------------Code--------------------------------------------

# boolean operator to ensure that the timer_label text and inputLineEdit are active after 
# start is pressed
var timeBool : bool = false
var tempTime : float = 0.0 # for the 'Timer' timer added in each play scene

var dungeonsPassed : int = 0 # tracks number of dungeons beat at START of game and for rest of game
var dungeonsPassed_ConstantChange : int = 0 # this is used to track the dungeons passed, 
# but is affected by the incorrect inputs; i.e. the 'dungeonsPassed' is used to keep track of all dungeons passed, but does not get reset
# tier-system will also not use dungeonsPassed_ConstantChange and will instead use dungeonsPassed, because it will be frustrating that u need 100 straight wins to change tier or more

#var tier = 0

var dP_and_nC_Checker : bool = false # used to 'switch' off the  'sd_timer' if statement in the _process() to avoid running that every 5 dungeons
# dP = dungeonsPassed; nC = 
var deductible_Multiplier : float = 0.0
var sdTimerCounter : float = 0.0 # counts time for duration the player is submitting correct inputs
# the above var will reset at an incorrect input

var hintsOn = false # boolValue checking if the 'hints' button has been triggered or not
var recentTempTime = 0.0 # var that stores the most recent 'timer' node time - used for when game
# is momentarily stopped becase the hints is switched 'on'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_panel.visible = false
	input_line_edit.visible = false
	var timerTime : float = timer.wait_time
	timer_label.text = "Timer: %d" % (timerTime) # check if i have to add '+1' to this and 
	# in the inspector of the 'Timer' node of the PDS_Control.tscn scene for 15 secs correctly
	
	#tier = GameManager.tier_checker(dungeonsPassed) # the global var that will be used thru-out game:
	# this global var will be used to extend the amount of time the player can see the 'display' 
	# and the var will also be used in the secondsPdungeon() func
	
	print(GameManager.currentPlayState)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tempTime = timer.time_left # becuase timer.time_left deafults at 0.0, because 
	# it is at the state that timer.time_wait hasnt started, thus, there is no time_left
	# therefore this temp var (tempTime) holds the most current time_left value
	# so that it can be used to add the 5.0s for the easy play
	# look at text_submitted signal for more info

	
	# following is chunk of code to run a timer to 0 using a boolVar set of TRUE
	# when the start button is pressed in the _on_start_button_pressed() signal code
	if timeBool:
		if hintsOn:
			timer_label.text = "Timer: " + str(int(recentTempTime)) + " - Slaying Halted!"
		else:
			timer_label.text = "Timer: %d" % (timer.time_left) 
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
		
		
		if dungeonsPassed_ConstantChange >= 5 and GameManager.correctInput_Checker(input_line_edit, dungeonsPassed) and dP_and_nC_Checker == false: # this is the grace period before the multiplier wrecks games - need finish 5 dungeons before multiplier takes effect
			print("yes")
			sd_timer.start() # starts the 'SD_Timer' meant to track the time for all successful inputs
			
			dP_and_nC_Checker = true



# Custom Functions:

# secondsPdungeon(secs, dung) function --> produces the amount of the deductible-time amount
# which will subtract from the main timer, 'timer', node
# calls within itself the 'tier_checker(dung)' function ------ see above 
func secondsPdungeon(seconds, dungeons) -> float:
	# 1 dungeone / 1 second = 1 D/S - this is an insane D/S
	# but this is too small a number to multiply and deduct time
	
	# 1 seconds / 1 dungeon = 1 S/D - this is how many seconds it takes to complete a dungeon
	# punish slow players: 30 sec / 2 dungeons = 15 S/D multiplier
	# help faster players: 100 sec / 90 dungeons = 1.111 S/D multiplier
	
	var tier = GameManager.tier_checker(dungeons) # - have to check if this statement is required as a single definition
## i.e. looking to make a global 'tier' var that will be used in this func, instead of a local
	
## tier now defined in _ready() func
	
	var deductibleMultiplier : float = seconds/dungeons
	
	var deductible = tier * (deductibleMultiplier)
	
	return deductible
# i think i have to deine it lovally, because everytime
# the signal is triggered, the 'tier' is redefined
# with the new dungeonsPassed var - this is indirect 
# updating of the var 'tier',  same as for the 
# input_line_edit() signal when we use it for the disaply_shut_timer_timer var, 
# by recalling thru a signal, we indirectly update for 
# the new 'tier' var, whereas: global 'tier' var does 
# not update because of where it is not placed in 
# _process(...) (i think), thus -> it does not update 
# and hit the certain thresholds intended to be hit 
# with the 'tier' var




func displayTimerShut_tierChecker(tier):
	var displayTimeMultiplier : int = 0
	
	if tier == 1:
		displayTimeMultiplier = 1 # time = 1.5 * 1 = 1.5 s
	
	elif tier > 1 and tier <= 3:
		displayTimeMultiplier = 1.4 # time = 1.5 * 1.4 = 2.1 s
	
	elif tier > 3 and tier <= 6:
		displayTimeMultiplier = 2 # time = 1.5 * 2 = 3 s
	
	elif tier >= 7:
		displayTimeMultiplier = 2.6 # time = 1.5 * 2.6 = 3.9 s
	
	return displayTimeMultiplier


# Signals:

func _on_start_button_pressed() -> void:
	print(dungeons_passed_label.text) # this is a viable statement
	print(timer_label.text) # this is a viable statement as well
	
	timer.start() # starts 'Timer' timer
	timeBool = true # makes the boolVar that keeps track if timer is on or not, be on
	#display_label.text	
	
	display_shut_timer_timer.start()
	
	input_panel.visible = true
	input_line_edit.visible = true
	input_line_edit.grab_focus() # ensure that the LineEdit is in 'focus' and player can 
	# freely type than refocusing it, upon pressing the start button
	
	GameManager.gameStart(display_label, dungeonsPassed) # initializes the appropriate variables and arrays to display
	# dungeonsPassed is used and dungeonsPassed_ConstantChange, because we need to display
	# all the points attained for the passed dungeons
	# tier-system will also use dungeonsPassed_ConstantChange, because it will be frustrating that u need 100 straight wins to change tier or more

func _on_back_button_pressed() -> void:
	GameManager.dungeonsGLOBAL = 0 # resets the hints-mechanic
	GameManager.hintsUsed = 0 # resets the hints-mechanic
	get_tree().change_scene_to_file("res://Scenes/play_control.tscn")

func _on_input_line_edit_text_changed(new_text: String) -> void:
	input_line_edit.text =  " " + input_line_edit.text
	var inputText = input_line_edit.text
	var newText2Display = ""
	for i in inputText:
		newText2Display += i
	

func _on_input_line_edit_text_submitted(new_text: String) -> void:
	# after text submitted (i.e. after ENTER pressed) we check first before clearing
	# testing if 'tier' func is working
	var tier = GameManager.tier_checker(dungeonsPassed) # i think i have to deine it lovally, because everytime
														# the signal is triggered, the 'tier' is redefined
														# with the new dungeonsPassed var - this is indirect 
														# updating of the var 'tier',  same as for the 
														# secondsPdungeons(..., dungeonsPassed) func, 
														# by recalling thru a signal, we indirectly update for 
														# the new 'tier' var, whereas: global 'tier' var does 
														# not update because of where it is not placed in 
														# _process(...) (i think), thus -> it does not update 
														# and hit the certain thresholds intended to be hit 
														# with the 'tier' var
	print("tier: ",  tier) 
	
	if input_line_edit.text == "":
		input_line_edit.placeholder_text = "Please input a 'solution'"

	elif GameManager.correctInput_Checker(input_line_edit, dungeonsPassed):
		display_shut_timer_timer.wait_time = 1.5 * displayTimerShut_tierChecker(tier)
		print("display timer: " + str(display_shut_timer_timer.wait_time))
		print("Hints Used: " + str(GameManager.hintsUsed) )
		
		display_label.visible = true
		input_panel_correct.visible = true # green bordered box made visible
		
		dungeonsPassed += 1 # will be used in the deductible_Multiplier
		dungeonsPassed_ConstantChange += 1 # the temp var that resets to 0 when an incorrect input is typed
		GameManager.dungeonsGLOBAL = dungeonsPassed # used for tier-system in the hintsDeduct scene or other scenes requiring the dungeonsPassed amount
		dungeons_passed_label.text = "Dungeons: " + str(dungeonsPassed)
		GameManager.score += 10
		timer.stop() # we temporarily stop the timer - dont know if we need this; doesnt affect running; DELETE THIS MAYBE
		timer.wait_time = tempTime + 5.0 # we manually-code-'reset' the timer.wait_time
		# property by adding the tempTime (holding the most current time_left value) 
		# with the added 5.0secs
		timer.start() # we continue the timer
		display_shut_timer_timer.start() # because i did this - display_shut_timer_timer.one_shot = true
		GameManager.gameStart(display_label, dungeonsPassed)

	else:
		input_panel_wrong.visible = true # red bordered box made visible
		timer.stop() # we temporarily stop the timer - dont know if we need this; doesnt affect running; DELETE THIS MAYBE
		print("seconds: ", sdTimerCounter, ", dungeons: ", dungeonsPassed_ConstantChange, ", ded.Multip.: ", secondsPdungeon(sdTimerCounter, dungeonsPassed))
		print("initial time: ", tempTime)
		
		#var deductible = 2.0 * (secondsPdungeon(sdTimerCounter, dungeonsPassed))
		
		var newTime_afterDeduction = tempTime - (secondsPdungeon(sdTimerCounter, dungeonsPassed_ConstantChange))
		# the temp version of 'dungeonsPassed' is used instead of the regular because 
		# the point is to calculated the new time based off the num of dungeons passed
		# over the elapsed time between the recent loss (and so new streak of wins)
		# to the win-attempt before the new loss 
		# so cant use regular dungeonsPassed, because that would caluclate for ALL dungeons passed, which is not game mechanic
		
		# we are calculating the instantaneous S/D from the dungeons between 2 losses, and not lifetime wins
		
		print(newTime_afterDeduction)

		if newTime_afterDeduction <= 0:
			timer.wait_time = 0.1
		elif is_nan(newTime_afterDeduction):
			timer.wait_time = tempTime
		else:
			timer.wait_time = newTime_afterDeduction # we manually-code-'reset' the timer.wait_time
		# property by adding the tempTime (holding the most current time_left value) 
		# with the subtracted 5.0secs multiplied with the multiplier of how fast players dungeons cleared per second
		
		print("final time: ", timer.wait_time) # checking time after the deduction
		
		sdTimerCounter = 0.0
		dungeonsPassed_ConstantChange = 0 # resetting the temp var to 0 because of the recent loss, 
		# but the regular 'dungeonsPassed' var is kept intact because that holds lifetime wins 
		timer.start() # we continue the timer
		
		
	GameManager.totalDungeons_Accomplished += 1 # represents the total levels played by the player irrespective of win or loss
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
		timer.wait_time = recentTempTime
		timer.start()
		hintsOn = false

#connected from 3 diff scenes (PlayEasy, PlayMedium, PlayHard)
func _on_timer_timeout() -> void:
	set_process(false) # ends the _process() function and runs the signals code
	print("You done!")
	timer_label.text = "Timer: done"
	
	get_tree().change_scene_to_file("res://Scenes/end_game_control.tscn")


func _on_sd_timer_timeout() -> void:
	sdTimerCounter += 1 # counts num seconds for all successful attempts
	print("this is printing now: ", sdTimerCounter)


func _on_hints_button_pressed() -> void:
	var tier = GameManager.tier_checker(dungeonsPassed)
	hintsOn = true
	GameManager.hintsUsed += 1
	
	# CAN PROB HAVE THIS SHOW UP IN THE ENG_GAME SCENE - BY HAVING AN 'ANIMATION' THAT 
	# DEMONSTRATES THE DEDUCTION OF THE HINTS PENALTY TO THE TOTAL SCORE
	# CAN ALSO HAVE A SIMILAR ANIMATION THAT DEMONSTRATES THAT THERE IS AN EFFECT OF THE
	# DEDUCTION FOR GOING ABOVE THE HINTS LIMIT - MAYBE IN THE HINTS BOX
	
	# put the for loop with the deduction stuff in the GameManager - in func - hintsDeduc_mechanic()
	GameManager.hintsDeduc_mechanic(GameManager.tier_checker(dungeonsPassed))
	# whats happening is that we call the hintsDeduc func from the GameManager_Singleton
	# and then we call the tier_checker from the GameManager as well, passing in all the successful 
	# dungeons the player has passed presently -> dungeonsPassed
	GameManager.hintsUsed_bool = true # flips a switch representing a hint has been used, will switch off
	GameManager.hints_Zero = false # indicates that player has selected a hint and there hintsUsed != 0
	
	recentTempTime = tempTime # getting the most recent time before stopping the 'timer' node
	timer.stop()
	display_shut_timer_timer.wait_time = 1.5 * displayTimerShut_tierChecker(tier)
	display_label.visible = true
	display_shut_timer_timer.start()
	
