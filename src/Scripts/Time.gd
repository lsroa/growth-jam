extends Label

func _process(_delta):
	self.text = str(stepify(Game.time, 0.01))

