class_name OyunMenu
extends Control

@export var Puan : Label

func _ready():
    Puan.text = "Puan : %s" % [OyunYT.ToplamPuan]


func _on_yan_oyun_oyna_pressed():
    OyunYT.yan_oyun_oynanmaya_basladi()
    get_tree().change_scene_to_file("res://Sahneler/YanOyun/YanOyunMenu.tscn")