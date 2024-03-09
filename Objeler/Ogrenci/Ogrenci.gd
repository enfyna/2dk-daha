class_name Ogrenci
extends Resource

var Ad : String
var DersCalismaMotivasyonu : float = 1.0

const AksiyonKlasor = "res://Objeler/Ogrenci/Aksiyon/"

var Aksiyonlar : Array
var AksiyonToplamOlasilik : float
var bulunulan_aksiyon : Aksiyon

func ayarla():
    var dir = DirAccess.open(AksiyonKlasor)
    for klasor in dir.get_files():
        var aksiyon : Aksiyon = ResourceLoader.load(AksiyonKlasor + klasor)
        Aksiyonlar.append(aksiyon)
        AksiyonToplamOlasilik += aksiyon.Olasilik
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
            continue
        elif not aksiyon_degisti and aks.Olasilik > sans:
            bulunulan_aksiyon = aks
            aksiyon_degisti = true
            continue
        if aks.Tip == Aksiyon.Tipler.Bos:
            aks.Olasilik += 0.03
        elif aks.Tip == Aksiyon.Tipler.Ders:
            aks.Olasilik += 0.01

func ders_calis():
    for aks : Aksiyon in Aksiyonlar:
        if aks.Tip == Aksiyon.Tipler.Ders:
            bulunulan_aksiyon = aks

func aksiyon_bitir():
    bulunulan_aksiyon.GecirilenSure += 2

    if bulunulan_aksiyon.Izdirap > 0 and  bulunulan_aksiyon.MinMotivasyon < bulunulan_aksiyon.Olasilik:
        bulunulan_aksiyon.Olasilik -= bulunulan_aksiyon.Izdirap
    elif bulunulan_aksiyon.Izdirap < 0 and  bulunulan_aksiyon.MinMotivasyon > bulunulan_aksiyon.Olasilik:
        bulunulan_aksiyon.Olasilik -= bulunulan_aksiyon.Izdirap
