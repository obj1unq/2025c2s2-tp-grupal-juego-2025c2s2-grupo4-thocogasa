object images {
    method peonNegro() = "PNegro.png"
    method peonBlanco(corono) = if (corono) "PBlancoCoronar.gif" else "PBlanco.png"
    method peonMuerto() = "PBlancoMuerto.gif"
    method caballoNegro() = "CNegro.png"
    method caballoBlanco() = "CBlanco.png"
    method alfilNegro() = "ANegro.png"
    method alfilBlanco() = "ABlanco.png"
    method torreNegro() = "TNegro.png"
    method torreBlanco() = "TBlanco.png"
    method piezaMuerta() = "PBlancoMuerto.gif"
}

class JaqueMate {
    const piezaDueña
    var property image = "CheckMate.gif"

    method position() = piezaDueña.position()
}