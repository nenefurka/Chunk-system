extends Node2D

var mapParams = Utility.mapParams
var chunks = []

# ------------------------- #

func _ready():
	# shift the tilemap by half the size of the chunk
	# so that the character is in the center during loading
	var chunkSize = (mapParams.CellSize * mapParams.ChunkSize) / 2
	$TileMap.position = -Vector2(chunkSize, chunkSize)

# update map
func updateChunks(chunkCoord):
	# creating chunks
	var extraChunks = chunks.duplicate()
	# we create [extraChunks] - loaded chunks, 
	# and from them we will delete those that are in the loading zone, 
	# only superfluous chunks will remain
	for xChunk in range(mapParams.ChunksRadius * 2 + 1):
		for yChunk in range(mapParams.ChunksRadius * 2 + 1):
			var chunkPos = Vector2(
				(xChunk - mapParams.ChunksRadius) + chunkCoord.x, 
				(yChunk - mapParams.ChunksRadius) + chunkCoord.y
			)
			# deleting chunk from extra chunks because it is in loading zone
			extraChunks.erase(chunkPos)
			# if chunk is already exist, skip it
			if chunks.has(chunkPos):
				continue
			# create chunk
			setChunk(chunkPos, 0)
			chunks.append(chunkPos)
	# we still have [extraChunks] that go beyond the liading zone
	
	# deleting extra chunks
	for pos in extraChunks:
		chunks.erase(pos)
		setChunk(pos, -1)
	
	# update bitmask if you need
	updateBitmask("TileMap")

# update chunk
func setChunk(chunkPos, tileIndex):
	for x in range(mapParams.ChunkSize):
		for y in range(mapParams.ChunkSize):
			var tilePos = Vector2(
				x + chunkPos.x * mapParams.ChunkSize, 
				y + chunkPos.y * mapParams.ChunkSize
			)
			$TileMap.set_cellv(tilePos, tileIndex)

func updateBitmask(tileMapName):
	var tileMap = get_node(tileMapName)
	
	var startPos = tileMap.get_used_rect().position
	var endPos = tileMap.get_used_rect().end
	tileMap.update_bitmask_region(startPos, endPos)
