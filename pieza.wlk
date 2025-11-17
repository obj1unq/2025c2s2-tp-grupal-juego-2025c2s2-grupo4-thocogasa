import oleadas.*
import rey.*

class Pieza {
    var property image
    var property position
    var property vidas
    var muerto
    var property valor
    var property ultimaFila
    const property color

    method mover(posiciónx, posicióny) {
        position = game.at(posiciónx, posicióny)
        self.esUltimaFila()
    }

    method esNegro()

    method estaDentroDelTablero(posicion) = (((posicion.x() >= 0) and (posicion.x() < 5)) and (posicion.y() >= 0)) and (posicion.y() < game.height())
    
    method posicionValida(posicion) {
        return self.estaDentroDelTablero(posicion) && !self.hayPiezaCompañera(posicion)
    }

    method hayPiezaCompañera(posicion) {
        return color.hayPieza(posicion)
    }

    method esUltimaFila() {
        ultimaFila = position.y() == ultimaFila
    }

    method posicionesCapturables() {}

    method perderVida() {
        vidas = vidas - 1
    }

    method desaparece() {
        game.schedule(500, { game.removeVisual(self) })
    }

    method capturar()

    method hayPiezaDeColor(_color, pos) {
        _color.hayPieza(pos)
    }
}

object negro {
    method hayPieza(pos) {
        return oleada.enemigosActivos().any({enemigo => enemigo.position() == pos})
    }
}

object blanco {
    method hayPieza(pos) {
        return reyBlanco.listaPiezasAliadas().any({aliado => aliado.position() == pos})
    }
}