extends Node

var score = 0

var time = 0
var is_playing


func start_timer(delta):

	if is_playing:
		time += delta

func stop_timer():
	is_playing = false

func restart_timer():
	time = 0
