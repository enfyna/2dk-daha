class_name Kitap
extends Resource

enum Tipi {
    Matematik,
    Klavye,
    Ozel,
}

enum Zorluk {
    Kolay,
    Orta,
    Zor,
}

class Soru:
    var Soru : String
    var Cevap : String


@export var Tip : Kitap.Tipi

func soru_al(zorluk : Kitap.Zorluk) -> Kitap.Soru:
    if Tip == Kitap.Tipi.Matematik:
        var soru : Soru = Soru.new()
        var rasgele_sayi : int = randi() % 10 * (zorluk + 2)
        soru.Soru = "%s x %s" % [rasgele_sayi, zorluk + 2] 
        soru.Cevap = "%s" % (rasgele_sayi * (zorluk + 2))
        return soru
    if Tip == Kitap.Tipi.Klavye:
         var soru : Soru = Soru.new()
         var rasgele_kelime : String
         var harfler : Array = ["h", "j", "k", "l"]
         for i in range((zorluk + 2) * 3):
             var rasgele_sayi : int = randi() % harfler.size() 
             rasgele_kelime = rasgele_kelime + harfler[rasgele_sayi]
         soru.Soru = rasgele_kelime
         soru.Cevap = rasgele_kelime
         return soru 

    return Soru.new()
