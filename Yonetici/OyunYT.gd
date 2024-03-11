extends Node

var ogrenci : Ogrenci
var toplam_puan : int
var YanOyunOynaniyorMu : bool = false

var ToplamPuan : int = 0
var _YanOyunPuan : float = 0.0

func oyunu_baslat():
    ogrenci = Ogrenci.new()
    ogrenci.ayarla()
    Saat.connect("iki_dk_gecti", iki_dk_gecti)
    Saat.saati_baslat()
    
func yan_oyun_oynanmaya_basladi():
    YanOyunOynaniyorMu = true

func yan_oyun_bitirildi():
    YanOyunOynaniyorMu = false
    var sure : float = 0.0
    var verimlilik : float = 0.0
    for aks : Aksiyon in ogrenci.Aksiyonlar:
        print(aks.Ad, aks.GecirilenSure)
        sure += aks.GecirilenSure
        verimlilik += aks.Puan * aks.GecirilenSure
    var ogrenci_katsayi = verimlilik / sure
    ToplamPuan += ceili(_YanOyunPuan * ogrenci_katsayi)
    return [sure, ogrenci_katsayi, _YanOyunPuan, ceili(_YanOyunPuan * ogrenci_katsayi)] 

func iki_dk_gecti():
    if YanOyunOynaniyorMu:
        ogrenci.aksiyon_bitir()
        ogrenci.aksiyon_basla()

func sahne_degistir(sahne_adi : String, mod : int = 0):
    var sahne = load(sahne_adi).instantiate()
    var suanki_sahne = get_tree().current_scene
    var tween = get_tree().create_tween()
    tween.set_parallel()
    if mod == 0:
        sahne.position.x = suanki_sahne.size.x
        get_tree().root.add_child(sahne)
        tween.tween_property(suanki_sahne, "position:x", -suanki_sahne.size.x, 0.2)
        tween.tween_property(sahne,"position:x", 0, 0.2)
    elif mod == 1:
        sahne.modulate = Color(0,0,0,0)
        get_tree().root.add_child(sahne)
        tween.tween_property(suanki_sahne, "modulate", Color(0,0,0), 0.2)
        tween.tween_property(sahne,"modulate", Color(1,1,1,1), 0.2)
        
    tween.set_parallel(false)
    tween.tween_callback(func(): suanki_sahne.queue_free())
    get_tree().current_scene = sahne
