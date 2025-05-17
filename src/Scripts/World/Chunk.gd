class_name Chunk

const size : int = 16
var position : Vector2i

var tiles : Array[Array] = []


func generate(noise : Noise) :
	for i in range(size):
		var tmp : Array = []
		for j in range(size):
			tmp.append(0)
		tiles.append(tmp)

func get_tile(n : float) -> int:
	if n < 0 :
		return 1
	return 0
