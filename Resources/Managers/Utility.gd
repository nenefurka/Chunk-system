extends Node

# you can change the params and see what happens
var mapParams = {
	"CellSize": 16,
	"ChunkSize": 4,
	"ChunksRadius": 3,
}

# ------------------------- #

func getChunkCoord(pos):
	var chunkSize = mapParams.CellSize * mapParams.ChunkSize
	var chunkCoord = Vector2(
		round(float(pos.x) / chunkSize),
		round(float(pos.y) / chunkSize)
	)
	return chunkCoord
