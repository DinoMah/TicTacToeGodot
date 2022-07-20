extends CanvasLayer

signal someoneGotThreePoints(ultimateWinner)

var winner: String
var p1Points: int
var p2Points: int

func _ready():
	p1Points = 0
	p2Points = 0
	hideElements()
	
func showElements():
	$PlayerOneLabel.show()
	$PlayerTwoLabel.show()
	$P1Point1.show()
	$P1Point2.show()
	$P1Point3.show()
	$P2Point1.show()
	$P2Point2.show()
	$P2Point3.show()

func updateBoard():
	$PointGained.play()
	if winner == "1":
		p1Points += 1
		get_node("P1Point" + str(p1Points)).animation = "on"
	else:
		p2Points += 1
		get_node("P2Point" + str(p2Points)).animation = "on"
	
	if p1Points == 3 || p2Points == 3:
		emit_signal("someoneGotThreePoints", winner)


func hideElements():
	$PlayerOneLabel.hide()
	$PlayerTwoLabel.hide()
	$P1Point1.hide()
	$P1Point2.hide()
	$P1Point3.hide()
	$P2Point1.hide()
	$P2Point2.hide()
	$P2Point3.hide()
	

func resetValues():
	p1Points = 0
	p2Points = 0
	for i in range(1, 3):
		for j in range(1, 4):
			get_node("P" + str(i) + "Point" + str(j)).animation = "off"
