class_name YanOyunSonuc
extends Control

@export var YaziContainer : VBoxContainer

func _ready():
    OyunYT.ogrenci.Aksiyonlar.sort_custom(
        func(a, b) : return a.GecirilenSure > b.GecirilenSure
    )
    var akslar = []
    var res = OyunYT.yan_oyun_bitirildi()
    var lbl = Label.new()
    lbl.add_theme_font_size_override("font_size", 25)
    lbl.text = "Ders anlattığın %s dakikada öğrencin bunları yaptı :" % [
        res[0],
    ]
    YaziContainer.add_child(lbl)

    for aks : Aksiyon in OyunYT.ogrenci.Aksiyonlar:
        if aks.GecirilenSure <= 0:
            continue
        var temp = lbl.duplicate()
        temp.text = "%3d Dk %s" % [
            aks.GecirilenSure,
            aks.Ad,
        ]
        akslar.push_back(temp)

    for i in akslar:
        YaziContainer.add_child(i)

    lbl = lbl.duplicate()
    lbl.text = "Öğrencin %.2f verimlilikle çalıştığı için kazandığın puan: %s x %.2f = %s" % [
        res[1],
        res[2],
        res[1],
        res[3],
    ]
    YaziContainer.add_child(lbl)


func _on_devam_et_pressed():
    get_tree().change_scene_to_file("res://Sahneler/Oyun/OyunMenu.tscn")

