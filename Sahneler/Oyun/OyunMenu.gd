class_name OyunMenu
extends Control

@export var Puan : Label

func _ready():
    Puan.text = "Puan : %s" % [OyunYT.ToplamPuan]


func _on_yan_oyun_oyna_pressed():
    OyunYT.yan_oyun_oynanmaya_basladi()
    get_tree().change_scene_to_file("res://Sahneler/YanOyun/YanOyunMenu.tscn")


func _on_motivasyon_arttır_pressed():
    Saat.sure_azalt(600)
    OyunYT.ogrenci.ders_motivasyonu_degistir(1.0)

