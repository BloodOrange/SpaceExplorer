extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var SPEED = 100.0
export(float) var live = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)

func _process(delta):
	#translation.x += SPEED * delta
	translate(Vector3(0, 0, -SPEED * delta))
	
	live -= delta
	if live < 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_area_entered(area):
	area.get_parent().queue_free()
	queue_free()
