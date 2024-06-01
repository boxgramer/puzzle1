extends Area2D


@onready var anim = $anim
var duration_stay:float = 5.0
var time:= 0.0
var is_have_body = false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", on_body_enter)
	connect("body_exited", on_body_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_have_body :
		return

	time -= delta;
	if time <= 0 :
		print("game success");
	pass

func on_body_enter(body: Node2D) :
	if body is main_character:
		$anim.play("active")	
		time = duration_stay
		is_have_body = true
	
func on_body_exited(body: Node2D) :
	if body is main_character:
		$anim.play("nonactive")	
		time = 0 
		is_have_body = false
	





