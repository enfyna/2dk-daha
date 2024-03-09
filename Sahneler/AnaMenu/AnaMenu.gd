class_name AnaMenu
extends Control

@export var ZorlukButonContainer : HBoxContainer

func _on_kolay_pressed():
    zorluk_ayarla("Kolay", Saat.Hiz.Yavas)

func _on_orta_pressed():
    zorluk_ayarla("Orta",  Saat.Hiz.Orta)

func _on_zor_pressed():
    zorluk_ayarla("Zor", Saat.Hiz.Hizli)

func zorluk_ayarla(isim : String, zorluk : Saat.Hiz):
    Saat.OyunHizi = zorluk
    for node : Button in ZorlukButonContainer.get_children():
        if node.text == isim:
            continue
        node.button_pressed = false

func _on_oyuna_basla_pressed():
    OyunYT.oyunu_baslat()
    get_tree().change_scene_to_file("res://Sahneler/Oyun/OyunMenu.tscn")
    pass

