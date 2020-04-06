extends Spatial

var speed = 0
var speed_max = 100
var acceleration = 10

puppet var puppet_position = Vector3()
puppet var puppet_orientation = 0
var speed_rotation = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().connect("connected_to_server", self, "connected_ok")
	pass

func connected_ok():
	#change_seat(get_tree().get_network_unique_id())
	pass

func _physics_process(delta):
	if is_network_master():
		var orientation = 0.0
		if Input.is_action_pressed("ui_up"):
			speed += acceleration * delta
			if speed > speed_max:
				speed = speed_max
		if Input.is_action_pressed("ui_down"):
			speed -= acceleration * delta
			if speed < 0:
				speed = 0
		if Input.is_action_pressed("ui_left"):
			orientation = speed_rotation * delta 
		if Input.is_action_pressed("ui_right"):
			orientation = -speed_rotation * delta
		
		rotate_y(orientation)
		translate(Vector3(0, 0, -speed * delta))
		rset_unreliable("puppet_position", translation)
		rset_unreliable("puppet_orientation", rotation.y)
	else:
		translation = puppet_position
		rotation.y = puppet_orientation

func change_seat(seat_id):
	if seat_id < 1:
		print("erreur de fauteuil")
		return
	
	var cameras = [$CaptainCamera, $CannonRF, $CannonLF, $CannonRB, $CannonLB]
	var next_camera = cameras[seat_id - 1]

	next_camera.current = true

func _input(event):
	if event is InputEventKey && event.scancode == KEY_ESCAPE:
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
