extends Node

enum Hiz {
	# gercek hayatta 1 saniye ...
	Yavas = 30, # ... oyunda 30 saniye
	Orta = 60,  # ... oyunda 60 saniye
	Hizli = 120, # ... oyunda 120 saniye
}

signal iki_dk_gecti

var SaatFormat : String = "%02d:%02d"
var SaatNode : VBoxContainer
var SaatText : Label
var MotivasyonGosterge = ProgressBar
var MotivasyonTween : Tween

var OyunHizi : Hiz = Hiz.Orta
var KalanZaman : float = 86400.0 / 4 #dk
var IkiDkGectiMi : float = 0.0 #dk
var OyunBasladiMi : bool = false

var SaatStr : String = "06:00"

func saati_baslat():
	SaatNode = load("res://Objeler/Saat/Saat.tscn").instantiate()
	SaatText = SaatNode.get_node("Text")
	SaatText.add_theme_font_size_override("font_size", 50)
	MotivasyonGosterge = SaatNode.get_node("Control/Motivasyon")
	MotivasyonGosterge.value = 0.0
	OyunYT.ogrenci.connect("ders_motivasyonu_degisti", ogrenci_motivasyon_guncelle)
	add_child(SaatNode)
	OyunBasladiMi = true

func _process(delta):
	if not OyunBasladiMi:
		return

	KalanZaman -= delta * OyunHizi
	if KalanZaman <= 0:
		OyunYT.sahne_degistir("res://Sahneler/OyunSonu/OyunSonu.tscn", 1)
		set_process(false)
		queue_free()

	IkiDkGectiMi += delta * OyunHizi

	if floorf(IkiDkGectiMi) > 120:
		IkiDkGectiMi = 0.0
		emit_signal("iki_dk_gecti")

	SaatStr = SaatFormat % [
		floor(KalanZaman / 3600),    
		floor(fmod(KalanZaman, 3600) / 60),
	]

	SaatText.text = SaatStr 

	return

func ogrenci_motivasyon_guncelle():
	MotivasyonTween = get_tree().create_tween()
	MotivasyonTween.tween_property(
		MotivasyonGosterge, "value", OyunYT.ogrenci.DersCalismaMotivasyonu, 0.1
	)
	MotivasyonTween.tween_property(
		MotivasyonGosterge, "modulate", Color(
				(1.0 - OyunYT.ogrenci.DersCalismaMotivasyonu) * 2.0,
				OyunYT.ogrenci.DersCalismaMotivasyonu,
				0.0,
				1.0
			),
			0.1
	)

func sure_azalt(saniye : int):
	KalanZaman -= saniye

func al():
	return SaatStr
