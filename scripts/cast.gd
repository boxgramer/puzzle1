extends RayCast2D

@export_enum('magnet', 'normal') var type:int = 0

var dir:int =0
var length:float = 0.0
var power : float = 10.0

var dir_vector:Vector2 = Vector2.ZERO
var colider= null
var is_push =true
var is_dead = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	set_direction(dir)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if is_dead :
		check_not_colide()
		return

	if is_colliding():	
		colider = get_collider();
		
		if colider is main_character:
			add_force_dir(dir , colider)

	check_not_colide()
func check_not_colide() :
	if not is_colliding() && colider != null && colider is main_character :
		check_up_down()
		check_left_right()
func check_up_down() :  
	#check direction is left or right 
	if dir == 2 || dir == 3 :
		return
	colider.is_on_force_up_down = false
	colider.velocity.y = 0
	colider = null

func check_left_right() :  
	#check direction is up or down
	if dir == 0 || dir == 1 :
		return
	colider.is_on_force_left_right= false
	colider.velocity.x = 0
	colider = null



func set_direction(dir : int):
	match (dir) :
		0: 
			dir_vector = Vector2.UP
		1:
			dir_vector = Vector2.DOWN
		2: 
			dir_vector = Vector2.LEFT
		3: 
			dir_vector = Vector2.RIGHT

	target_position = dir_vector * length

func add_force_dir(dir:int, colider:main_character) :
	match (dir) :
		0: 
			colider.up()
			colider.is_on_force_up_down = true
		1:
			colider.down()
			colider.is_on_force_up_down = true
		2: 
			colider.left()
			colider.is_on_force_left_right= true
		3: 
			colider.right()
			colider.is_on_force_left_right= true

	#type normal
	if type == 1:
		if is_push :
			colider.push()
		else :
			colider.pull()
	elif type != 1 and not is_dead :
	
		if (is_push && colider.type == 1) || (!is_push && colider.type ==0):
			colider.pull()
		if (is_push && colider.type == 0) || (!is_push && colider.type ==1):
			colider.push()
	

	

	colider.set_power(power)


