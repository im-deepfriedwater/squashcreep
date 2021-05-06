extends Node

export (PackedScene) var mob_scene
onready var readyScreen =  $UserInterface/Retry

func _ready():
    randomize()
    readyScreen.hide()

func _on_MobTimer_timeout() -> void:
    var mob = mob_scene.instance()
    
    var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
    mob_spawn_location.unit_offset = randf()
    
    var player_position = $Player.transform.origin
    
    add_child(mob)
    mob.initialize(mob_spawn_location.translation, player_position)
    
    mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


func _on_Player_hit() -> void:
    $MobTimer.stop()
    readyScreen.show()
    
    
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
        get_tree().reload_current_scene()
    
    
