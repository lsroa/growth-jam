extends Node

var score = 0

var time = 0

func start_timer(delta):
	time += delta
	print(time)

func restart_timer():
	time = 0
