extends Button

signal cellPressed(cellNumber)

var cellNumber: int

func _ready():
	$AnimatedSprite.animation = "none"

func _on_Cell_pressed():
	emit_signal("cellPressed", cellNumber)
