extends Node2D


func _ready():
	$GatoTable.visible = false
	$UltimateWinner.hide()
	$InfoLabel.hide()
	$PlayAgainButton.hide()


func initPlayers():
	$PointsBoard.resetValues()
	$GatoTable.isCircleTurn = $TurnSelect.isCircleSelected
	if $TurnSelect.isCircleSelected: $GatoTable.playerOne = "circle"
	else: $GatoTable.playerOne = "cross"
	$GatoTable.visible = true
	$PointsBoard.showElements()


func _on_GatoTable_someoneWon(winner):
	$PointsBoard.winner = winner
	$PointsBoard.updateBoard()
	$GatoTable.theresWinner = false


func _on_PointsBoard_someoneGotThreePoints(ultimateWinner):
	$UltimateWinner.text = "Jugador " + ultimateWinner + " ha ganado."
	$WinnerTimer.start()


func _on_GatoTable_theresDraw():
	$InfoLabel.show()
	$DrawTimer.start()
	
	
func markDraw():
	pass


func show_winner():
	$GatoTable.hide()
	$PointsBoard.hideElements()
	$UltimateWinner.show()
	$PlayAgainButton.show()
	$WinnerSound.play()


func _on_DrawTimer_timeout():
	$InfoLabel.hide()


func _on_PlayAgainButton_pressed():
	$PlayAgainButton.hide()
	$UltimateWinner.hide()
	initGame()
	
	
func initGame():
	$TurnSelect.showGuiElements()
