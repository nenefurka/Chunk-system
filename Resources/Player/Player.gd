extends KinematicBody2D

# movement
var speed = 100
var motion = Vector2.ZERO

# params
var currentChunkCoord = null

# ------------------------- #

func _physics_process(delta):
	# default player movement
	getInput()
	move(delta)
	
	# сhunk change check function
	updateChunk()

func getInput():
	motion = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		motion.x = 1
	if Input.is_action_pressed("Left"):
		motion.x = -1
	if Input.is_action_pressed("Down"):
		motion.y = 1
	if Input.is_action_pressed("Up"):
		motion.y = -1
	
	motion = motion.normalized() * speed

func move(delta):
	move_and_slide(motion)

func updateChunk():
	var newChunkCoord = Utility.getChunkCoord(self.global_position)
	if newChunkCoord == currentChunkCoord:
		return
	
	# if the chunk coordinate has changed, we update the tileset
	owner.updateChunks(newChunkCoord)
	currentChunkCoord = newChunkCoord
