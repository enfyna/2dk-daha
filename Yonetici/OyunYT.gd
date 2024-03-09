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
