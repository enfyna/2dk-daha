class_name Aksiyon
extends Resource

enum Tipler {
    Ders,
    Bos,
    Ihtiyac,
}

@export var Ad : String
@export var Olasilik : float 
@export var Izdirap : float
@export var MinMotivasyon : float
@export var Puan : float
@export var Tip : Aksiyon.Tipler

var GecirilenSure : float = 0.0
