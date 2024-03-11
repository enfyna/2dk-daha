extends Node

var ad : AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
    # when _ready is called, there might already be nodes in the tree, so connect all existing buttons
    ad.stream = load("res://Ses/Buton/click.mp3")
    add_child(ad)
    connect_buttons(get_tree().root)
    get_tree().connect("node_added", _on_SceneTree_node_added)

func _on_SceneTree_node_added(node):
    if node is Button:
        connect_to_button(node)

func _on_Button_pressed():
    ad.play()

func connect_buttons(root):
    for child in root.get_children():
        if child is BaseButton:
            connect_to_button(child)
        connect_buttons(child)

func connect_to_button(button):
    button.connect("pressed", _on_Button_pressed)

