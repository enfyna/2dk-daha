class_name OyunMenu
extends Control

@export var Puan : Label
var KarakterDers : TextureRect

func _ready():
    KarakterDers = get_node("karakterders")
    KarakterDers.visible = OyunYT.ogrenci.DersCalismaMotivasyonu > 0.8
    Saat.connect("iki_dk_gecti", iki_dk_gecti)
    Puan.text = "Puan : %s" % [OyunYT.ToplamPuan]

func _on_yan_oyun_oyna_pressed():
    OyunYT.yan_oyun_oynanmaya_basladi()
    OyunYT.sahne_degistir("res://Sahneler/YanOyun/YanOyunMenu.tscn")


func _on_motivasyon_arttır_pressed():
    var ad = AudioStreamPlayer.new()
    ad.stream = load("res://Ses/motivasyon.mp3")
    add_child(ad)
    ad.play()
    Saat.sure_azalt(600)
    KarakterDers.visible = true
    var btn = get_node("HBoxContainer/CenterContainer/VBoxContainer/MotivasyonArttır")
    btn.visible = false
    OyunYT.ogrenci.ders_motivasyonu_degistir(1.0)

func iki_dk_gecti():
    OyunYT.ToplamPuan -= 2
    Puan.text = "Puan : %s" % [OyunYT.ToplamPuan]
