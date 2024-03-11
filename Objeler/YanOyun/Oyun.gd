class_name Oyun
extends Resource

signal soru_cevaplandi(cevap : String, puan : int)
signal akis_orani(zorluk : int, oran : float, renk : Color)

@export var Ad : String
@export var Puan : float
@export var Oyun_Kitap : Kitap

var KazanilanPuan : int = 0
var SoruBilmeSerisi : int = 0
var AnlikSoru : Kitap.Soru
var AnlikZorluk : Kitap.Zorluk = Kitap.Zorluk.Kolay

var CevapLineEdit : LineEdit
var SoruTextBox : Label
var SonucContainer : HBoxContainer
var BasariliSonuc : ColorRect
var HataliSonuc : ColorRect

func sec(textbox : Label, line_edit : LineEdit, sonuc : HBoxContainer):
    SoruTextBox = textbox

    SonucContainer = sonuc
    BasariliSonuc = SonucContainer.get_node("yesil").duplicate()
    HataliSonuc = SonucContainer.get_node("kirmizi").duplicate()
    SonucContainer.remove_child(SonucContainer.get_node("yesil"))
    SonucContainer.remove_child(SonucContainer.get_node("kirmizi"))

    CevapLineEdit = line_edit
    CevapLineEdit.connect("text_changed", soru_kontrol_et)

    yeni_soru_al()
    
func yeni_soru_al():
    var soru = Oyun_Kitap.soru_al(AnlikZorluk)
    AnlikSoru = soru
    SoruTextBox.text = soru.Soru

func soru_kontrol_et(input : String):
    if input.length() < AnlikSoru.Cevap.length():
        return

    var node
    if AnlikSoru.Cevap.to_lower() == input.to_lower():
        var puan = (AnlikZorluk + 1) * 5
        KazanilanPuan += puan
        SoruBilmeSerisi += 1
        node = BasariliSonuc.duplicate()
    else: 
        KazanilanPuan -= 20
        SoruBilmeSerisi = 0
        node = HataliSonuc.duplicate()
    
    emit_signal("soru_cevaplandi", AnlikSoru.Cevap, SoruBilmeSerisi)

    SonucContainer.add_child(node)
    SonucContainer.move_child(node, 0)
    node.size_flags_stretch_ratio = 0
    var tween = SonucContainer.get_tree().create_tween()
    tween.tween_property(node, "size_flags_stretch_ratio", 1, 0.2)

    CevapLineEdit.text = ""

    zorluk_ayarla()
    yeni_soru_al()

func zorluk_ayarla():
    if SoruBilmeSerisi < 10:
        AnlikZorluk = Kitap.Zorluk.Kolay
        emit_signal("akis_orani", AnlikZorluk + 1,SoruBilmeSerisi / 10.0, Color(0, 1, 1))
    elif SoruBilmeSerisi < 25:
        AnlikZorluk = Kitap.Zorluk.Orta
        emit_signal("akis_orani", AnlikZorluk + 1,SoruBilmeSerisi / 25.0, Color(1, 0, 1))
    else:
        AnlikZorluk = Kitap.Zorluk.Zor
        emit_signal("akis_orani", AnlikZorluk + 1, 1.0, Color(1, 1, 0))


