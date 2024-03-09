extends Node

enum Hiz {
    # gercek hayatta 1 saniye ...
    Yavas = 30, # ... oyunda 30 saniye
    Orta = 60,  # ... oyunda 60 saniye
    Hizli = 120, # ... oyunda 120 saniye
}

signal iki_dk_gecti

var SaatFormat : String = "%02d:%02d"
var SaatNode : Label

var OyunHizi : Hiz = Hiz.Orta
var KalanZaman : float = 86400.0 / 4 #dk
var IkiDkGectiMi : float = 0.0 #dk
var OyunBasladiMi : bool = false

var SaatStr : String = "06:00"

func saati_baslat():
    var node = load("res://Objeler/Saat/Saat.tscn").instantiate()
    SaatNode = node.get_node("Label").duplicate()
    SaatNode.add_theme_font_size_override("font_size", 50)
    add_child(SaatNode)
    OyunBasladiMi = true

func _process(delta):
    if not OyunBasladiMi:
        return

    KalanZaman -= delta * OyunHizi
    IkiDkGectiMi += delta * OyunHizi

    if floorf(IkiDkGectiMi) > 120:
        IkiDkGectiMi = 0.0
        emit_signal("iki_dk_gecti")

    SaatStr = SaatFormat % [
        floor(KalanZaman / 3600),    
        floor(fmod(KalanZaman, 3600) / 60),
    ]

    SaatNode.text = SaatStr

    return

func al():
    return SaatStr
