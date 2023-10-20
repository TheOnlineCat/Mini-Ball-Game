extends RichTextLabel
var points = 0
func increase_score():
	points += 1
	self.text = str(points)
