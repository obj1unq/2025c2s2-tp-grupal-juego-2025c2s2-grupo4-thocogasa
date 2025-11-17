import oleadas.*
object images {
    method peonNegro() = "PNegro.png"
    method peonBlanco(corono) = if (corono) "PBlancoCoronar.gif" else "PBlanco.png"
    method caballoNegro() = "CNegro.png"
    method caballoBlanco() = "CBlanco.png"
    method alfilNegro() = "ANegro.png"
    method alfilBlanco() = "ABlanco.png"
    method torreNegro() = "TNegro.png"
    method torreBlanco() = "TBlanco.png"
    method piezaMuerta() = "PBlancoMuerto.gif"
    method transicionOleada() = "OleadaGanada.gif"
    method rey() = "RBlanco.png"
    method rey1() = "RBlanco1Hit.png"
    method rey2() = "RBlanco2Hit.png"
    method rey3() = "RBlanco3Hit.png"
}

class JaqueMate {
    const piezaDueña
    var property image = "CheckMate.gif"

    method position() = piezaDueña.position()
}

class Coronación {
    const piezaDueña
    var property image = "Coronacion.gif"

    method position() = piezaDueña.position()
}