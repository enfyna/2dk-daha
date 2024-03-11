class_name YanOyunMenu
extends Control

@export var YanOyunlar : Array
@export var YanOyunOynaButonu : Button
@export var AkisSayisi : Label
@export var PuanGosterge : Label
@export var CevapGosterge : Label
@export var Particles : CPUParticles2D

var YanOyunContainer : VBoxContainer
var ButonContainer : GridContainer
var AkisOrani : ProgressBar
var Ses : AudioStreamPlayer
var YanOyun : Oyun

func _ready():
    YanOyunContainer = get_node("%YanOyunContainer")
    ButonContainer = get_node("%YanOyunButonContainer")
    YanOyunContainer.hide()
    YanOyunOynaButonu.hide()
    Ses = AudioStreamPlayer.new()
    Ses.stream = load("res://Ses/correct.mp3")
    add_child(Ses)

    var temp_button : Button = ButonContainer.get_child(0, true)
    for oyun : Oyun in YanOyunlar:
        var button = temp_button.duplicate()
        if oyun.Oyun_Kitap.Tip == Kitap.Tipi.Matematik:
            button.theme_type_variation = "MaviButon"
        elif oyun.Oyun_Kitap.Tip == Kitap.Tipi.Klavye:
            button.theme_type_variation = "SariButon"
        else:
            if oyun.Oyun_Kitap.Ad == "Kimya":
                button.theme_type_variation = "YesilButon"
            elif oyun.Oyun_Kitap.Ad == "ZitKelimeler":
                button.theme_type_variation = "KirmiziButon"
            elif oyun.Oyun_Kitap.Ad == "Atasozleri":
                button.theme_type_variation = "MorButon"
        button.text = oyun.Ad
        button.connect("pressed", yan_oyun_oyna.bind(oyun))
        ButonContainer.add_child(button)

    CevapGosterge = YanOyunContainer.get_node("SonucCevap")
    AkisOrani = AkisSayisi.get_node("AkisOrani")
    ButonContainer.remove_child(temp_button)
    ButonContainer.show()

func yan_oyun_oyna(oyun : Oyun):
    var tw = get_tree().create_tween()
    tw.tween_property(ButonContainer, "modulate", Color(1,1,1,0), 0.2)
    tw.tween_callback(func(): ButonContainer.queue_free())
    YanOyun = oyun
    YanOyun.connect("soru_cevaplandi", soru_cevaplandi)
    YanOyun.connect("akis_orani", akis_orani_guncelle)
    YanOyun.sec(
        YanOyunContainer.get_node("Soru"),
        YanOyunContainer.get_node("Cevap"),
        YanOyunContainer.get_node("Sonuc"),
    )
    var cevap = YanOyunContainer.get_node("Cevap")
    await get_tree().process_frame
    cevap.grab_focus()

    YanOyunContainer.modulate = Color.TRANSPARENT
    YanOyunContainer.show()
    tw.tween_property(YanOyunContainer, "modulate", Color(1,1,1,1), 0.2)
    YanOyunOynaButonu.show()

func akis_orani_guncelle(zorluk : int, oran : float, renk : Color):
    var tween = get_tree().create_tween()
    tween.tween_property(AkisSayisi, "modulate", renk, 0.2)
    tween.tween_property(AkisOrani, "modulate", renk, 0.2)
    tween.tween_property(AkisOrani, "value", oran, 0.2)

    var ad
    if AkisSayisi.text.to_int() < zorluk:
        ad = AudioStreamPlayer.new()
        ad.stream = load("res://Ses/akis_atla.mp3")
        add_child(ad)
        ad.play()
        Particles.color = renk
        Particles.emitting = true
    elif AkisSayisi.text.to_int() > zorluk:
        ad = AudioStreamPlayer.new()
        ad.stream = load("res://Ses/hata.mp3")
        add_child(ad)
        ad.play()

    AkisSayisi.text = "%s" % [zorluk]
    PuanGosterge.text = "%s" % [YanOyun.KazanilanPuan]


func _on_ogrenci_kontrol_et_pressed():
    OyunYT._YanOyunPuan = YanOyun.KazanilanPuan
    OyunYT.sahne_degistir("res://Sahneler/YanOyunSonuc/YanOyunSonuc.tscn")

func soru_cevaplandi(cevap : String, puan : int):
    CevapGosterge.text = cevap
    if puan > 0:
        Ses.play()
    CevapGosterge.theme_type_variation = "Dogru" if puan > 0 else "Yanlis"

func _on_pas_gec_pressed():
    var cevap = YanOyunContainer.get_node("Cevap")
    cevap.text = ""
    YanOyun.yeni_soru_al()
    await get_tree().process_frame
    cevap.grab_focus()
    
