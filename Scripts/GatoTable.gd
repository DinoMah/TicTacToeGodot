extends GridContainer

signal someoneWon(whoWon)
signal theresDraw

export (PackedScene) var Cell
var button = []

# var screenSize = get_viewport_rect().size
var isCircleTurn: bool
var theresWinner = false
var playerOne: String


func _ready():
	var posX = 0
	var posY = 0
	var cellNum = 0
	for _y in range(3):
		for _x in range(3):
			button.append(Cell.instance())
			button[cellNum].rect_position.x = posX
			button[cellNum].rect_position.y = posY
			button[cellNum].cellNumber = cellNum
			button[cellNum].connect("cellPressed", self, "cellPressed")
			$".".add_child(button[cellNum])
			cellNum += 1


func cellPressed(cellNumber):
	if !button[cellNumber].disabled:
		button[cellNumber].disabled = true
		if isCircleTurn:
			setCellIcon(cellNumber, "circle", false)
		else:
			setCellIcon(cellNumber, "cross", true)
		checkCells()


func setCellIcon(cellNumber: int, animation: String, circleTurn: bool):
	button[cellNumber].get_node("AnimatedSprite").animation = animation
	isCircleTurn = circleTurn


func checkCells():
	if !theresWinner:
		checkRows()
	if !theresWinner:
		checkCols()
	if !theresWinner:
		checkDiagonals()
	checkRemainingCells()


func checkRows():
	var noIcon = "none"
	var circle = "circle"
	var cross = "cross"
	
	var firstIcon: String
	var secondIcon: String
	var thirdIcon: String
	
	for i in range(0, 9, 3):
		firstIcon = button[i].get_node("AnimatedSprite").animation
		secondIcon = button[i+1].get_node("AnimatedSprite").animation
		thirdIcon = button[i+2].get_node("AnimatedSprite").animation
		if firstIcon == noIcon || secondIcon == noIcon || thirdIcon == noIcon:
			continue
		if firstIcon == circle && secondIcon == circle && thirdIcon == circle:
			theresWinner = true
			connectTimer(circle)
		if firstIcon == cross && secondIcon == cross && thirdIcon == cross:
			theresWinner = true
			connectTimer(cross)


func checkCols():
	var noIcon = "none"
	var circle = "circle"
	var cross = "cross"
	var firstIcon: String
	var secondIcon: String
	var thirdIcon: String
	
	for i in range(3):
		firstIcon = button[i].get_node("AnimatedSprite").animation
		secondIcon = button[i+3].get_node("AnimatedSprite").animation
		thirdIcon = button[i+6].get_node("AnimatedSprite").animation
		if firstIcon == noIcon || secondIcon == noIcon || thirdIcon == noIcon:
			continue
		if firstIcon == circle && secondIcon == circle && thirdIcon == circle:
			theresWinner = true
			connectTimer(circle)
		if firstIcon == cross && secondIcon == cross && thirdIcon == cross:
			theresWinner = true
			connectTimer(cross)


func checkDiagonals():
	checkPrincipalDiagonal()
	if !theresWinner:
		checkInverseDiagonal()
	
	
func checkPrincipalDiagonal():
	var circle = "circle"
	var cross = "cross"
	var firstIcon = button[0].get_node("AnimatedSprite").animation
	var secondIcon = button[4].get_node("AnimatedSprite").animation
	var thirdIcon = button[8].get_node("AnimatedSprite").animation
	if firstIcon == circle && secondIcon == circle && thirdIcon == circle:
		theresWinner = true
		connectTimer(circle)
	if firstIcon == cross && secondIcon == cross && thirdIcon == cross:
		theresWinner = true
		connectTimer(cross)
	

func checkInverseDiagonal():
	var circle = "circle"
	var cross = "cross"
	var firstIcon = button[2].get_node("AnimatedSprite").animation
	var secondIcon = button[4].get_node("AnimatedSprite").animation
	var thirdIcon = button[6].get_node("AnimatedSprite").animation
	if firstIcon == circle && secondIcon == circle && thirdIcon == circle:
		theresWinner = true
		connectTimer(circle)
	if firstIcon == cross && secondIcon == cross && thirdIcon == cross:
		theresWinner = true
		connectTimer(cross)

		
func checkRemainingCells():
	var remainingCells = 0
	for i in range(9):
		if button[i].get_node("AnimatedSprite").animation == "none":
			remainingCells += 1
	if remainingCells < 3:
		$DrawTimer.start()

func emitDraw():
	clearBoard()
	emit_signal("theresDraw")


func connectTimer(winner):
	if !$WaitTimer.is_connected("timeout", self, "whichPlayerWon"):
		$WaitTimer.connect("timeout", self,"whichPlayerWon", [winner])
	else:
		$WaitTimer.disconnect("timeout", self, "whichPlayerWon")
		$WaitTimer.connect("timeout", self,"whichPlayerWon", [winner])
	$WaitTimer.start()


func whichPlayerWon(winner):
	clearBoard()
	
	if playerOne == "circle":
		isCircleTurn = true
	else:
		isCircleTurn = false
	
	if playerOne == winner:
		emit_signal("someoneWon", "1")
	else:
		emit_signal("someoneWon", "2")
		

func clearBoard():
	for e in range(9):
		button[e].get_node("AnimatedSprite").animation = "none"
		button[e].disabled = false
	






