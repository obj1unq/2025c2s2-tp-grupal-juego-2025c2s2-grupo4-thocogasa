import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import aliado.*

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
}

class PeonBlanco inherits Aliado(valor = 20, image = images.peonBlanco()) {
    override method posicionesDiagonales() = [self.position().up(1).left(1), self.position().up(1).right(1)]
}

class CaballoBlanco inherits Aliado(valor = 50, image = images.caballoBlanco()) {
    override method posicionesDiagonales() = [self.position().up(2).left(1), self.position().up(2).right(1), self.position().up(1).left(2), self.position().up(1).right(2), self.position().down(2).left(1), self.position().down(1).left(2), self.position().down(2).right(1), self.position().down(1).right(2)]
}