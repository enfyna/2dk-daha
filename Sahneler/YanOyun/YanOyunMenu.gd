class_name YanOyunMenu
extends Control

@export var ButonContainer : HBoxContainer
@export var YanOyunContainer : VBoxContainer
@export var YanOyunlar : Array
@export var YanOyunOynaButonu : Button
@export var OgrenciDersMotivasyon : Range

var YanOyun : Oyun

func _ready():
    YanOyunContainer.hide()
    YanOyunOynaButonu.hide()

    var temp_button : Button = ButonContainer.get_child(0, true)
    for oyun : Oyun in YanOyunlar:
        var button = temp_button.duplicate()
        button.text = oyun.Ad
        button.connect("pressed", yan_oyun_oyna.bind(oyun))
        ButonContainer.add_child(button)

    ButonContainer.remove_child(temp_button)
    ButonContainer.show()

func yan_oyun_oyna(oyun : Oyun):
    ButonContainer.queue_free()
    YanOyun = oyun
    #oyun.connect("basarili")
    #oyun.connect("hatali")
    YanOyun.sec(
        YanOyunContainer.get_node("Soru"),
        YanOyunContainer.get_node("Cevap"),
        YanOyunContainer.get_node("Sonuc"),
    )
    YanOyunContainer.show()
    YanOyunOynaButonu.show()

func _on_ogrenci_kontrol_et_pressed():
    OyunYT._YanOyunPuan = YanOyun.KazanilanPuan
    print(OyunYT._YanOyunPuan)
    print(YanOyun.KazanilanPuan)
    get_tree().change_scene_to_file("res://Sahneler/YanOyunSonuc/YanOyunSonuc.tscn")

