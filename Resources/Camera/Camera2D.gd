extends Camera2D

var states = [Vector2(1, 1), Vector2(4, 4)]
var index = 0

# ------------------------- #

func _input(_event):
	if Input.is_action_just_pressed("LeftClick"):
		changeIndex()

func changeIndex():
	index += 1
	if index == states.size():
		index = 0
	changeZoom()

func changeZoom():
	self.zoom = states[index]
