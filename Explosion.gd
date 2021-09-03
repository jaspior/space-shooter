extends Sprite

func _ready():
	$Timer.connect("timeout",self,"queue_free")


	
