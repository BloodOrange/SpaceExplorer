extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var angle_x_min = -60.0
export(float) var angle_x_max = 60.0
export(float) var angle_y_min = -45.0
export(float) var angle_y_max = 45.0

export var current = false setget set_current

export(float) var default_fire_rating = 0.1
var fire_rating = 0.0

var next_silo = 0

const Laser = preload("res://Laser.tscn")

onready var CannonCamera = $CannonBase/CannonTurret/Camera

func set_current(new_current):
	current = new_current
	
	$CanvasLayer/CenterContainer.visible = current
	CannonCamera.current = current

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fire():
	var laser = Laser.instance()
	laser.translation.z -= translation.length() * 1.1
	if next_silo == 0:
		$CannonBase/CannonTurret/CannonSilo0.add_child(laser)
		next_silo = 1
	else:
		$CannonBase/CannonTurret/CannonSilo1.add_child(laser)
		next_silo = 0

func _process(delta):
	if fire_rating > 0:
		fire_rating -= delta
		
		if fire_rating < 0:
			fire_rating = 0.0
	
	if not current:
		return
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if fire_rating == 0.0:
			fire_rating = default_fire_rating
			fire()

func _input(event):
	if not current:
		return

	if event is InputEventMouseMotion:
		var rotx = $CannonBase.rotation_degrees.y - event.relative.x / 10.0
		$CannonBase.rotation_degrees.y = clamp(rotx, angle_x_min, angle_x_max)
		
		var roty = $CannonBase/CannonTurret.rotation_degrees.x - event.relative.y / 5.0
		$CannonBase/CannonTurret.rotation_degrees.x = clamp(roty, angle_y_min, angle_y_max)
