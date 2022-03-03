extends Node

#var goalScore = 20
var score = 0

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func enemy_killed():

	score+=1
	print("score is")
	print(score)
	get_tree().get_root().get_node("Lobby/UI/UserInterface/ScoreLabel").text = "Score: "+str(score)
