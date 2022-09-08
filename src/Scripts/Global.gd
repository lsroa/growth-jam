extends Node

var score = 0

var time = 0

func start_timer(delta):
	time += delta


func restart_timer():
	time = 0
