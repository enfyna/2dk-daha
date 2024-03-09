class_name YanOyunMenu
extends Control

@export var ButonContainer : HBoxContainer
@export var YanOyunContainer : VBoxContainer
@export var YanOyunlar : Array
@export var YanOyunOynaButonu : Button
@export var AkisSayisi : Label
var AkisOrani : ProgressBar

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

    AkisOrani = AkisSayisi.get_node("AkisOrani")
    ButonContainer.remove_child(temp_button)
    ButonContainer.show()

func yan_oyun_oyna(oyun : Oyun):
    ButonContainer.queue_free()
    YanOyun = oyun
    #oyun.connect("basarili")
    #oyun.connect("hatali")
    YanOyun.connect("akis_orani", akis_orani_guncelle)
    YanOyun.sec(
        YanOyunContainer.get_node("Soru"),
        YanOyunContainer.get_node("Cevap"),
        YanOyunContainer.get_node("Sonuc"),
    )
    YanOyunContainer.show()
    YanOyunOynaButonu.show()

func akis_orani_guncelle(zorluk : int, oran : float, renk : Color):
    var tween = get_tree().create_tween()
    tween.tween_property(AkisSayisi, "modulate", renk, 0.2)
    tween.tween_property(AkisOrani, "modulate", renk, 0.2)
    tween.tween_property(AkisOrani, "value", oran, 0.2)

    AkisSayisi.text = "%s" % [zorluk]

func _on_ogrenci_kontrol_et_pressed():
    OyunYT._YanOyunPuan = YanOyun.KazanilanPuan
    get_tree().change_scene_to_file("res://Sahneler/YanOyunSonuc/YanOyunSonuc.tscn")

