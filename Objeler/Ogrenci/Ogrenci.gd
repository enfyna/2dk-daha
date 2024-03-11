class_name Ogrenci
extends Resource

signal ders_motivasyonu_degisti

var Ad : String
var DersCalismaMotivasyonu : float = 0.0

const AksiyonKlasor = "res://Objeler/Ogrenci/Aksiyon/"

var Aksiyonlar : Array
var bulunulan_aksiyon : Aksiyon

func ayarla():
    Aksiyonlar.clear()
    var dir = DirAccess.open(AksiyonKlasor)
    for dosya in dir.get_files():
        if dosya.ends_with(".remap"):
            dosya = dosya.replace(".remap", "")
        var aksiyon : Aksiyon = ResourceLoader.load(AksiyonKlasor + dosya)
        Aksiyonlar.append(aksiyon)
        if aksiyon.Tip == Aksiyon.Tipler.Ders:
            bulunulan_aksiyon = aksiyon

func aksiyon_basla():
    var sans = randf() 
    var aksiyon_degisti : bool = false
    Aksiyonlar.sort_custom(func(a, b): return b.Olasilik > a.Olasilik)
    for aks : Aksiyon in Aksiyonlar:
        # ogrenci, oyuncu yan oyunu actiginda ilk 8 dk ders calissin
        if DersCalismaMotivasyonu > 0.8:
            if not aksiyon_degisti and aks.Tip == Aksiyon.Tipler.Ders:
                bulunulan_aksiyon = aks
                aksiyon_degisti = true
                ders_motivasyonu_degistir(-0.05)
            continue
        elif not aksiyon_degisti and aks.Olasilik > sans:
            if aks.Tip == Aksiyon.Tipler.Ders:
                if DersCalismaMotivasyonu < 0.2:
                    continue
                ders_motivasyonu_degistir(-0.05)
            bulunulan_aksiyon = aks
            aksiyon_degisti = true
            continue
        if aks.Tip == Aksiyon.Tipler.Bos:
            aks.Olasilik += 0.03
        elif aks.Tip == Aksiyon.Tipler.Ders:
            aks.Olasilik += 0.01
    if not aksiyon_degisti:
        aksiyon_basla()

func ders_calis():
    for aks : Aksiyon in Aksiyonlar:
        if aks.Tip == Aksiyon.Tipler.Ders:
            bulunulan_aksiyon = aks

func ders_motivasyonu_degistir(deger : float):
    DersCalismaMotivasyonu += deger
    DersCalismaMotivasyonu = clampf(DersCalismaMotivasyonu, 0.0, 1.0)
    emit_signal("ders_motivasyonu_degisti")

func aksiyon_bitir():
    bulunulan_aksiyon.GecirilenSure += 2

    if bulunulan_aksiyon.Izdirap > 0 and  bulunulan_aksiyon.MinMotivasyon < bulunulan_aksiyon.Olasilik:
        bulunulan_aksiyon.Olasilik -= bulunulan_aksiyon.Izdirap
    elif bulunulan_aksiyon.Izdirap < 0 and  bulunulan_aksiyon.MinMotivasyon > bulunulan_aksiyon.Olasilik:
        bulunulan_aksiyon.Olasilik -= bulunulan_aksiyon.Izdirap
