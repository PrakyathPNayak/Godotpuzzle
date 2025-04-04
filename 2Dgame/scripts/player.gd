extends CharacterBody2D
signal done
var can_move=true
var inventory={"key":10,"gear":10}
var Score=0
const max_speed = 300.0
const friction = 1000.0
const accel =1500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var input=Vector2.ZERO
func _physics_process(delta):
	player_movement(delta)
func get_input():
	input.x=int(Input.is_action_pressed("right"))-int(Input.is_action_pressed("left"))
	input.y=int(Input.is_action_pressed("downward"))-int(Input.is_action_pressed("forward"))
	return input.normalized()
func player_movement(delta):
	input=get_input()
	if input==Vector2.ZERO:
		if velocity.length()>(friction*delta):
			velocity-=velocity.normalized()*(friction*delta)
		else :
			velocity=Vector2.ZERO
	else:
		velocity+=(input*accel*delta)
		velocity=velocity.limit_length(max_speed)
	
	move_and_slide()
func _picked(item):
	Score+=300
	match(item):
		"key": inventory["key"]+=1
		"gear":inventory["gear"]+=1

func dialouge(cl,pr):
	await $Camera2D/CanvasLayer/player_ui.start(cl,pr)
func instruct(ins):
	$Camera2D/CanvasLayer/player_ui.instruction(ins)
func _on_player_ui_dialouge_done():
	emit_signal("done")
