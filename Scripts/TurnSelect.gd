extends CanvasLayer

signal circle_selected
signal cross_selected

var isCircleSelected = false

func _ready():
	pass


func _on_CrossSelect_pressed():
	hideGuiElements()
	emit_signal("cross_selected")


func _on_CircleSelect_pressed():
	isCircleSelected = true
	hideGuiElements()
	emit_signal("circle_selected")
	
	
func showGuiElements():
	$CircleSelect.show()
	$CrossSelect.show()
	$SelectPlayerIconLabel.show()


func hideGuiElements():
	$CircleSelect.hide()
	$CrossSelect.hide()
	$SelectPlayerIconLabel.hide()
