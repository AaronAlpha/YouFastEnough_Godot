extends Control

@onready var hints_left_panel: Panel = $HintsLeft_Panel
@onready var hints_restore_timer: Timer = $HintsRestore_Timer
@onready var display_shut_timer_mini_timer: Timer = $DisplayShutTimer_MINI_Timer
@onready var more_hints_check_timer: Timer = $MoreHintsCheck_Timer
@onready var hints_restore_while_timer: Timer = $HintsRestoreWHILE_Timer
@onready var above_hint_label: Label = $AboveHint_Label

var screenSize : Vector2
var tier : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test values for the HintsDed system
	#tier = 6 # testing var for checking if display is good
	#GameManager.score = 1000
	#GameManager.hintsUsed = 11
	
	screenSize = get_viewport_rect().size

	
func _draw() -> void:
	# real val
	tier = GameManager.tier_checker(GameManager.dungeonsGLOBAL) # will be used to reduce the number of 
	# hints-chances players will have as their tier increases
	
	# this var had to update in here, by defining in _read(), I had hard-coded the value
	# but redefining this var in _draw() AND queue_redraw() in the _process(), 
	# I am able to have tier-system work 
	
	# beauce I only define it once in the _ready() body, but don't re-call/update the var


	if tier == 1:
		#print("tier 1")
		tier1Deduct_Display(GameManager.hintsUsed)
	
	elif tier == 2:
		#print("tier 2")
		tier2Deduct_Display(GameManager.hintsUsed)
	
	elif tier == 3: 
		#print("tier 3")
		tier3Deduct_Display(GameManager.hintsUsed)
		
	elif tier == 4:
		#print("tier 4")
		tier4Deduct_Display(GameManager.hintsUsed)
	
	elif tier == 5:
		#print("tier 5")
		tier5Deduct_Display(GameManager.hintsUsed)
	
	elif tier == 6:
		#print("tier 6")
		tier6Deduct_Display(GameManager.hintsUsed)
	
	elif tier == 7:
		#print("tier 7")
		tier7Deduct_Display(GameManager.hintsUsed)
	
	elif tier == 8:
		#print("tier 8")
		tier8Deduct_Display(GameManager.hintsUsed)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# redraws the _draw() func to update when tier or hintsUsed changes
	queue_redraw() 
	
	if GameManager.hintsUsed_bool == true: # starts the restoring hints functionality by triggering a func
		# that starts another timer to allow for the restorignHints functionality 
		
		# this causes the restore timers (plural) to stop and not be running anyways
		# without the stopping of the 2 timers, the 2 timers continue running, 
		# so we cannot achieve the effect of stopping the hints restoration till the seelction of hints have stopped
		hints_restore_timer.stop()
		hints_restore_while_timer.stop()
		more_hints_check_timer.start()
		
		GameManager.hintsUsed_bool = false # switching of switch so that it can be re-flipped when a hint has been used again



# Custom Functions

func tier1Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 3:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 4:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 5:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			 
		elif hints == 6:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 7:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 8:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 1.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier2Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 3:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 4:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 5:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 6:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 7:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 8, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier3Deduct_Display(hints):
	if hints== 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 3:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints== 4:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 5:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 6:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 2.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier4Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 3:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 4:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 5:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 7, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier5Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 3:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 4:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 3.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier6Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 3:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 6, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier7Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
		
	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)
			
		elif hints == 2:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 4.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5.5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			
func tier8Deduct_Display(hints):
	if hints == 0:
		draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.DARK_GREEN)

	elif hints != 0:
		if hints == 1:
			draw_circle(Vector2( (hints_left_panel.size.x / 10) * 5, hints_left_panel.position.y + hints_left_panel.size.y/2), 25, Color.FIREBRICK)
			
			




# work on hintsRestoration timing stuff:


# whats happening in the next 3 signals?
	# more_hints_timer checks for if anymore hints have been selected
	# if so timer restarts until there have been no hints for 1.5sec
	
	# if no more hints in the 1.5sec -> hints_restore_timer is started within the more_hints_timer signal
	
	# when the hints_restore_timer ends -> i.e. on that signal's timeout() signal -> we decrement the 
	# hintsUsed var every 0.8secs that will be 0.7 sec timer of the hints_restore_timer and 0.1 sec from
	# the hints_restore_while_timer signal
	
	# hints_restore_while_timer -> this timer acts as a while-loop that re-runs the timer of the 
	# hints_restore_timer (which decrements the hints) until the hints are reduced to below the limit
	# and to hints of 0



# Signals

# checks if there are more hints to come (1.5 sec)
func _on_more_hints_check_timer_timeout() -> void:
	hints_restore_timer.start()
	

# signal for HintsDeduc scene that restores the hints used (0.8 sec)
func _on_hints_restore_timer_timeout() -> void:	
	GameManager.hintsUsed -= 1
	
	# checks if hints == 0 -> if so, stops timer; if not, continues timer process till hints == 0
	if GameManager.hintsUsed == 0:
		GameManager.hints_Zero = true
	else:
		hints_restore_while_timer.start()

func _on_hints_restore_while_timer_timeout() -> void:
	hints_restore_timer.start()
