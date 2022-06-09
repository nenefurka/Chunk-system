extends VBoxContainer

# ------------------------- #

func _physics_process(delta):
	var playerPos = owner.get_node("Player").global_position
	$GlobalPos/Value.text = str(Vector2(round(playerPos.x), round(playerPos.y)))
	$ChunkPos/Value.text = str(Utility.getChunkCoord(playerPos))
