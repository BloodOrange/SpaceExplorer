extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var angle_x_min = -60.0
export var angle_x_max = 60
export var angle_y_min = -45.0
export var angle_y_max = 45

export var current = false setget set_current

func set_current(new_current):
	current = new_current
	
	$CanvasLayer/CenterContainer.visible = current
	$CannonTurret/Camera.current = current

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if not current:
		return

	if event is InputEventMouseMotion:
		var rotx = $CannonTurret.rotation_degrees.y - event.relative.x / 10.0
		$CannonTurret.rotation_degrees.y = clamp(rotx, angle_x_min, angle_x_max)
		
		var roty = $CannonTurret/Camera.rotation_degrees.x - event.relative.y / 5.0
		$CannonTurret/Camera.rotation_degrees.x = clamp(roty, angle_y_min, angle_y_max)
