extends Node

var score = 0
var total_score = 2

var time = 0
var is_playing


func restart_score():
	score = 0

func start_timer(delta):

	if is_playing:
		time += delta

func stop_timer():
	is_playing = false

func restart_timer():
	time = 0
