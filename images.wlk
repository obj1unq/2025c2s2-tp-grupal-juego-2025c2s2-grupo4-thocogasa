object images {
    method peonNegro() = "PNegro.png"
    method peonBlanco() = "PBlanco.png"
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

    method position() {
        try {
            return piezaDueña.position()
        } catch e : MessageNotUnderstoodException {
            return game.center()
        }
    }
}