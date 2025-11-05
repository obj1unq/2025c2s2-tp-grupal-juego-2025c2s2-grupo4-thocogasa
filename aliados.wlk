import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import aliado.*
import images.*

class PeonBlanco inherits Aliado(valor = 20, image = images.peonBlanco(false)) {
    override method posicionesDiagonales() = [self.position().up(1).left(1), self.position().up(1).right(1)]
    override method mover(posiciónx, posicióny) {
        super(posiciónx, posicióny)
        self.intentarCoronar()
    }
}

class CaballoBlanco inherits Aliado(valor = 50, image = images.caballoBlanco()) {
    override method posicionesDiagonales() = [self.position().up(2).left(1), self.position().up(2).right(1), self.position().up(1).left(2), self.position().up(1).right(2), self.position().down(2).left(1), self.position().down(1).left(2), self.position().down(2).right(1), self.position().down(1).right(2)]
}