extends Sprite

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("left"):
		flip_h = true
	elif Input.is_action_pressed("right"):
		flip_h = false
