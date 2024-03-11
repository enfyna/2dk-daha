extends Control

var ad = AudioStreamPlayer.new()

func _ready():
    var yazi = get_node("MarginContainer/Control2/MarginContainer/VBoxContainer/OyunSonuYazısı")
    if OyunYT.ToplamPuan > 100:
        ad.stream = load("res://Ses/success.mp3")
        yazi.text = yazi.text % [
            OyunYT.ToplamPuan 
        ]
    else:
        ad.stream = load("res://Ses/fail.mp3")
        var terlik = get_node("Basarili")
        terlik.visible = false
        yazi.text = "Başaramadın!\nNe yazık ki %s puan alarak öğrencini vaktinde hazırlayamadın." % [
            OyunYT.ToplamPuan
        ]
    add_child(ad)
    ad.play()

func _on_ayrıl_pressed():
    get_tree().quit()

