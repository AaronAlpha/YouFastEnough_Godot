extends Node

# Game Manager, all important variables

# following variables are for keeping track of a game session
var score = 0 # number of successful levels passed in a *game session* * 10 = score
var totalDungeons_Accomplished = 0 # total number levels passed in a *game session*
var longestStreak_counting = 0 # longest streak for a *game session* - counting while in streak
var longestStreak_final = 0 # longest streak for a *game session* - most recent, before losing the streak

var dungeonsGLOBAL = 0 # keeps track of the num of dungeons GLOBALly so that 
						# the num of dungeons can be passed into a func outside of the gameplay scenes
var hintsUsed = 0 # var that can be used across scenes so as to connect the playScenes to the hinstDeduction Scene
# is a value that will span between 0-8 (0: no hints used | 8: all hints used)
var hintsUsed_bool : bool = false # used to check if a hint is used
var hints_Zero : bool = true # var that checks if hintsUsed = 0

# dont need:
var hintsAboveLimit : bool = false # used to check if the Hints are above the tier's hintLimit



# following variables are for the 'stats' scene - the stats of a person
var highestScore_Lifetime = 0 # highest number of successful dungeons passed in entire game
var totalDungeonsPlayed_Lifetime = 0 # total num of dungeons accomplished lifetime

# following are for keeping track of which playScene we're on
var playState = ["easy", "medium", "hard"] # = ["DungeonsSlayers", "VanillaSpeedrunners", "SequencesSpeedrunners"]
var currentPlayState = "nothing"

# following arrays for holding the display for a game playScene
var arrayToHold_DungeonSlayersDisplay = []
var arrayToHold_VanillaSpeedrunners = []
var arrayToHold_SequencesSpeedrunners= []

var r = RandomNumberGenerator.new() # randomizer variable from the Godot Documentation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Custom Functions:

# the randomizer functions - there are 7 randomizer funcstions
# the 7 mirror the 
func numbers_Randomizer():
	var list1 = []
	for i in range(5):
		list1.append( int( str(r.randf_range(0, 9)) ) )
	return list1

func specialChars_Randomizer():
	var list1 = []
	var specialChars = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', "?"]
	for i in range(5):
		list1.append(int( str(r.randf_range(0, 15))))
	var SelectedSpecialCharsList = [] # all randomly choosen alphabets
	for i in list1:
		SelectedSpecialCharsList += [specialChars[i]] # same as an append statement
	return SelectedSpecialCharsList

func Numbers_and_SpecialChars_Randomizer():
	var list1 = [] # picking the specific number of 
	var listR = [] # alphanumeric list
	var allChars = ["0", "1", "2", "3", "4", "5", "6", "7", "8" ,"9", 
	'!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', "?"]
	for i in range(5):
		list1.append(int( str(r.randf_range(0, 25)))) # gets the random numbers
	for i in list1:
		listR.append(allChars[i]) # indexes the 'AllChars' 
	return listR

func LOWERalphabets_Randomizer():
	var list1 = []
	var alphabets_LOWER = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
	for i in range(5):
		list1.append(int( str(r.randf_range(0, 26))))
	var SelectedAlpabetsList_LOWER = [] # all randomly choosen alphabets
	for i in list1:
		SelectedAlpabetsList_LOWER += [alphabets_LOWER[i]] # same as an append statement
	return SelectedAlpabetsList_LOWER
	
func UPPERalphabets_Randomizer():
	var list1 = []
	var alphabets_UPPER = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
	for i in range(5):
		list1.append(int( str(r.randf_range(0, 26))))
	var SelectedAlpabetsList_UPPER = [] # all randomly choosen alphabets
	for i in list1:
		SelectedAlpabetsList_UPPER += [alphabets_UPPER[i]] # same as an append statement
	return SelectedAlpabetsList_UPPER
	
func ALLalphabets_Randomizer():
	var list1 = []
	var alphabets_ALL = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
	for i in range(5):
		list1.append(int( str(r.randf_range(0, 51))))
	var SelectedAlpabetsList_ALL = [] # all randomly choosen alphabets
	for i in list1:
		SelectedAlpabetsList_ALL += [alphabets_ALL[i]] # same as an append statement
	return SelectedAlpabetsList_ALL

func allChars_Randomizer():
	var list1 = [] # picking the specific number of 
	var listR = [] # alphanumeric list
	var allChars = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
	"0", "1", "2", "3", "4", "5", "6", "7", "8" ,"9", 
	'!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', "?"]
	for i in range(5):
		list1.append(int( str(r.randf_range(0, 77)))) # gets the random numbers
	for i in list1:
		listR.append(allChars[i]) # indexes the 'AllChars' 
	return listR
	


# func that holds the blend of all above 3 func and more (introducing special characters)
func GamePlay_DS_and_VS(dungeons): # GamePlay for "Dungeon Slayers" and "Vanilla Speedrunners"
	var tier = tier_checker(dungeons)
	
	var listCharacters = [] # final gamePlay list
	
	if tier == 1:
		listCharacters = numbers_Randomizer()
	
	elif tier == 2:
		listCharacters = specialChars_Randomizer()
	
	elif tier == 3:
		listCharacters = Numbers_and_SpecialChars_Randomizer()
		
	elif tier == 4:
		listCharacters = LOWERalphabets_Randomizer()
	
	elif tier == 5:
		listCharacters = UPPERalphabets_Randomizer()
	
	elif tier == 6:
		listCharacters = ALLalphabets_Randomizer()
	
	elif tier == 7:
		listCharacters = allChars_Randomizer()
	
	return listCharacters # returning the list of chars



func GamePlay_SS(dungeons): # GamePlay for "Sequences Speedrunners"	
	var allShapesList = [ "⬤", "▲", "■", "▮", "⬟","⬢", "⬣", "⬬", "◆" ,"⯊","▰","⬧"]
	
	var gameShapesDisplay = []
	
	var tier = tier_checker(dungeons)
	
	if tier < 4:
		for i in range(0, 4):
			gameShapesDisplay.append(allShapesList[i])
	
	elif tier < 8:
		for i in range(4, 8):
			gameShapesDisplay.append(allShapesList[i])
	
	elif tier >= 8:
		for i in range(8, 12):
			gameShapesDisplay.append(allShapesList[i])
		
	return gameShapesDisplay



# Checker function --> compares line_edit's input and the randomly generated display
# because this function was orignially apart of a scene with a NODE included in the code
# i needed to pass in a 'placeholder object' as the parameter required by the function
# which will access the '.text' property of the 'placeholder' - LineEdit node
func correctInput_Checker(inputLineEdit_Node, dungeons) -> bool:
	var inputLineEdit_Array = []
	var tier = tier_checker(dungeons) # used to check the tier and ensure there is no appending errors due to diff data types
	
	
	## HAVE TO TEST IF THIS DATA TYPE STUFF IS OKAY:
	if tier == 1: # we only apply this tier-checking rule for tier1, because the 'arrHolder' which we compare the input to later on are made up of integers
		# however, all other tierX gameplays will utilize only Strings, even numbers as strings
		for i in inputLineEdit_Node.text:
			inputLineEdit_Array.append(int(i)) #NOTE, we have to be careful, the input is String not int
	# .append(INT(...)) changes String into number 0!!
	else:
		for i in inputLineEdit_Node.text:
			inputLineEdit_Array.append((i)) #NOTE, we have to be careful, the input is String not int
	
	#print("my input: ", inputLineEdit_Array) # print statment that shows my input
	 
	var arrHolder = []
	
	if currentPlayState == "easy": # easy = DungeonSlayers
		arrHolder = arrayToHold_DungeonSlayersDisplay
	elif currentPlayState == "medium": # medium = VanillaSpeedrunners
		arrHolder = arrayToHold_VanillaSpeedrunners


	if inputLineEdit_Array == arrHolder:
		longestStreak_counting += 1
		return true
	else:
		longestStreak_final = longestStreak_counting
		longestStreak_counting = 0
		return false

# Game_Start function --> after the START button is pressed, the gameStart() func 
# initializes all the required variables and arrays to display in the display_label
# passed in a 'placeholder' that acts as a node that allows me to access its '.text' property
# and allows me to change the font size of the placeholder/node
func gameStart(displayLabel_Node, dungeons) -> void:
	if currentPlayState == "easy":
		arrayToHold_DungeonSlayersDisplay = GamePlay_DS_and_VS(dungeons)  
		print(arrayToHold_DungeonSlayersDisplay)
		var TextVariableHolder = "" # to hold the randomized array in String Variable
		for i in arrayToHold_DungeonSlayersDisplay: 
			TextVariableHolder += str(i) + " "
		# for-loop that iterates thru and adds each element in the array into string with space
		# NOTE: there should be an extra space at the end of String Var because of iteration
		# Quality of life: remove extra space at end
		#print(TextVariableHolder)
		
		displayLabel_Node.text = TextVariableHolder # displays to the Display_Label
		displayLabel_Node.add_theme_font_size_override("font_size", 100)
		# above changes the fontSize of the display_label
		
	elif currentPlayState == "medium":
		arrayToHold_VanillaSpeedrunners = GamePlay_DS_and_VS(dungeons) 
		print(arrayToHold_VanillaSpeedrunners)
		var TextVariableHolder = "" # to hold the randomized array in String Variable
		for i in arrayToHold_VanillaSpeedrunners:
			TextVariableHolder += str(i) + " "
		# for-loop that iterates thru and adds each element in the array into string with space
		# NOTE: there should be an extra space at the end of String Var because of iteration
		# Quality of life: remove extra space at end
		
		displayLabel_Node.text = TextVariableHolder # displays to the Display_Label
		displayLabel_Node.add_theme_font_size_override("font_size", 100)
		# above changes the fontSize of the display_label
		
	elif currentPlayState == "hard":
		arrayToHold_SequencesSpeedrunners = GamePlay_SS(dungeons)
		print(arrayToHold_SequencesSpeedrunners)
		var TextVariableHolder = "" # to hold the randomized array in String Variable
		for i in arrayToHold_SequencesSpeedrunners:
			TextVariableHolder += str(i) + " "
		# for-loop that iterates thru and adds each element in the array into string with space
		# NOTE: there should be an extra space at the end of String Var because of iteration
		# Quality of life: remove extra space at end
		
		displayLabel_Node.text = TextVariableHolder # displays to the Display_Label
		displayLabel_Node.add_theme_font_size_override("font_size", 100) 
		# above changes the fontSize of the display_label

# tier_checker(dung) function --> func that determines the approrpriate tier-multiplier for the
# time deduction

# CHECK THIS IF-STATEMENT LOGIC
func tier_checker(dungeons) -> int:
	var num = 0
	var tiersArr = [1, 2, 3, 4, 5, 6, 7, 8]

## testing-gameplay tiers
	if dungeons <= 5: # tier 1
		num = tiersArr[0]
	
	elif dungeons <= 10: # tier 2
		num = tiersArr[1]
	
	elif dungeons <= 15: # tier 3
		num = tiersArr[2]
	
	elif dungeons <= 20: # tier 4
		num = tiersArr[3]
	
	elif dungeons <= 30: # tier 5
		num = tiersArr[4]
		
	elif dungeons <= 45: # tier 6
		num = tiersArr[5]
	
	elif dungeons <= 50: # tier 7
		num = tiersArr[6]
		
	elif dungeons <= 60: # tier 8
		num = tiersArr[7]



## true gameplay tiers
	#if dungeons <= 50:
		#num = tiersArr[0]
	#
	#elif dungeons <= 100: 
		#num = tiersArr[1]
	#
	#elif dungeons <= 150:
		#num = tiersArr[2]
	#
	#elif dungeons <= 200:
		#num = tiersArr[3]
	#
	#elif dungeons <= 300:
		#num = tiersArr[4]
		#
	#elif dungeons <= 450:
		#num = tiersArr[5]
	#
	#elif dungeons <= 500:
		#num = tiersArr[6]
		#
	#else: # for greater than 500 dungeons passed
		#num = tiersArr[7]


	return num


# for all hintsUsed above the set number of hints left (based) on the tier
	# we will deduct 10 point-scores per hint above THAT tier's hintsUsed limit
		# eg: tier 3 -> num hintsUsed limit = 6 -> any hint used above 6 hints 
		# (lets say we are 5 hints above the 6 hint-limit), will result in:
		# a deduction of: (10 * ( 11 (hints used) - 6 (hint limit) ))
		# (5 hintsUsed above 6)
func hintsDeduc_mechanic(tier):
	var arr = [1, 2, 3, 4, 5, 6, 7, 8] # used for hintsDeduct calculator (see _process() HintsScene)
	
	for i in range(1, 9):
		if tier == i:
			if GameManager.hintsUsed > arr[-i]:
				GameManager.score -= (10 * ( GameManager.hintsUsed - arr[-i]) )
				print((10 * ( GameManager.hintsUsed - arr[-i]) ))
				break
	print(GameManager.score)






# DONT NEED FOLLOWING FUNC..... for a bit (determined useless after hintsTimer work)

func hintsAboveLimit_checker(tier : int):
	var arr = [1, 2, 3, 4, 5, 6, 7, 8] # used for hintsDeduct calculator (see _process() HintsScene)
	
	for i in range(1, 9):
		if tier == i:
			if GameManager.hintsUsed > arr[-i]:
				return true
	
	return false


func hintsRestore_trigger(tier : int, timer : Timer):
	var arr = [1, 2, 3, 4, 5, 6, 7, 8] # used for hintsDeduct calculator (see _process() HintsScene)
	
	for i in range(1, 9):
		if tier == i:
			if GameManager.hintsUsed > arr[-i]:
				hintsAboveLimit = hintsAboveLimit_checker(tier)
				timer.start()
				break
