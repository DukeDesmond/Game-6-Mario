class_name Attack extends State
@export var audio_player : AudioStreamPlayer2D
@export var sword_hit_box : CollisionShape2D
var buffer : bool = false
# Called when the node enters the scene tree for the first time.
func enter():
	if !player:
		push_warning("Player not exported in Attack State!")
	
	if !player:
		push_warning("No hitbox exported in Attack State!")
	else:
		sword_hit_box.disabled = false
		
	playback.travel("attack_1")
	audio_player.stream =load( "res://sound/442903__qubodup__slash.wav")
	audio_player.play()
	buffer = false
	player.can_move = false

func exit():
	sword_hit_box.disabled = true
	
func state_process(delta):
	if player.life <= 0:
		transitioned.emit(self,"Death")
	

func state_physics_process(delta):
	pass
	
func state_input(event : InputEvent):
	if event.is_action_pressed("attack") and buffer == false:
		buffer = true

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_1":
		if buffer == true:
			playback.travel("attack_2")
			audio_player.stream =load( "res://sound/442903__qubodup__slash.wav")
			audio_player.play()
		else:
			transitioned.emit(self,"Grounded")
	
	elif anim_name == "attack_2":
		transitioned.emit(self,"Grounded")
	
	else:
		transitioned.emit(self,"Grounded")
