extends Node2D



@onready var anim = $anim
@onready var body = $body
@onready var mark = $mark
@onready var mark_anim = $mark/anim

var state = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	anim_state(state)
	body.connect("input_event", inputEvent)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func inputEvent(_node:Viewport, event: InputEvent , _shape:int) :
	if event is InputEventMouseButton :
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT :
			state +=1
			state = state % 2
			anim_state(state)

func anim_state(state:int) :
	match (state) :
		0 : 
			anim.pause()
			mark_anim.pause()
		1 : 
			anim.play("pusher")
			mark_anim.play('run')
