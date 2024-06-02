extends Node

var score = 0

func add_point():
	score += 1
	print(score)

func become_host():
	print("Become Host Pressed")
	%MultiplayerHUD.hide()
	MultiplayerManager.become_host()

func join_as_player_2():
	print("Joined as Player 2")
	%MultiplayerHUD.hide()
	MultiplayerManager.join_as_player_2()
