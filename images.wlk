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