extends Node2D

export (Array) var adjacentRooms
export (PoolVector2Array) var playerSpawnPositions

func _ready():
	if GlobalVariables.lastRoom != null:
		$Player.position = playerSpawnPositions[adjacentRooms.find(GlobalVariables.lastRoom)]
