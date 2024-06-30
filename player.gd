extends CharacterBody3D

@onready var cam = $Neck/Cam
@onready var options = $Options
@onready var back_to_game = $"Options/back to game"
@onready var crosshair = $Crosshair


# Movement
var speed = 5
var gravity = 12
var jump_force = 4

# Camera
var sensivity = 0.001

var in_options = false

func _ready(): 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
 


func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED :
		rotation.y += -event.relative.x * sensivity
		cam.rotation.x += -event.relative.y * sensivity
		cam.rotation.x = clamp(cam.rotation.x,deg_to_rad(-45),deg_to_rad(45))



func _process(delta):
	if Input.is_action_just_pressed("options") and !in_options:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		in_options = true
		options.show()
		crosshair.hide()
	elif Input.is_action_just_pressed("options") and in_options:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		in_options = false
		options.hide()
		crosshair.show()
		
	

func _physics_process(delta):
	velocity.y -= gravity * delta
	
	var move_input = Input.get_vector("left","right","forward","backward")
	var direction = transform.basis * Vector3(move_input.x,0,move_input.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	
	move_and_slide()


func _on_back_to_game_pressed():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		in_options = false
		options.hide()
		crosshair.show()
