import oleadas.*
import rey.*
import images.*

class Pieza {
    var property imagePieza
    var property position = game.at(0, 0)
    var property vidas = 1
    var muerto = false
    var property valor
    var property ultimaFila
    const property color
    const accesorio

    method image() = if(muerto) images.piezaMuerta() else imagePieza

    method mover(posiciónx, posicióny) {
        position = game.at(posiciónx, posicióny)
    }
    
    method estaDentroDelTablero(posicion) = (((posicion.x() >= 0) and (posicion.x() < 5)) and (posicion.y() >= 0)) and (posicion.y() < game.height())
    
    method posicionValida(posicion) {
        return self.estaDentroDelTablero(posicion) && !self.hayPiezaCompañera(posicion)
    }

    method hayPiezaCompañera(posicion) {
        return color.hayPieza(posicion)
    }

    method esUltimaFila() {
        return ultimaFila == position.y()
    }

    method posicionesCapturables()

    method perderVida() {
        vidas = vidas - 1
    }

    method desaparece() {
        muerto = true
        if (game.hasVisual(accesorio)) {
            game.removeVisual(accesorio)
        }
        game.schedule(500, { game.removeVisual(self) })
    }

    method intentarCapturar() {
        var capturado = false

        self.posicionesCapturables().forEach { pos =>  
            if (self.puedeCapturar(pos)) {
                const pieza = color.piezaContrariaEn(pos)
                self.capturar(pieza)
                capturado = true
            }
        }
    }

    method puedeCapturar(pos) {
        return self.posicionValida(pos) && color.piezaContrariaEn(pos)
    }

    method capturar(pieza) {
        const posicionCaptura = pieza.position()
        self.mover(posicionCaptura.x(), posicionCaptura.y())
        pieza.desaparece()
    }

    method hayPiezaDeColor(_color, pos) {
        _color.hayPieza(pos)
    }
}

object negro {
    method hayPieza(pos) {
        return oleada.enemigosActivos().any({enemigo => enemigo.position() == pos})
    }

    method piezaEn(pos) {
        return oleada.enemigosActivos().find({enemigo => enemigo.position() == pos})
    }

    method piezaContrariaEn(pos) {
        return blanco.piezaEn(pos)
    }
}

object blanco {
    method hayPieza(pos) {
        return reyBlanco.listaPiezasAliadas().any({aliado => aliado.position() == pos})
    }

    method piezaEn(pos) {
        return reyBlanco.listaPiezasAliadas().find({aliado => aliado.position() == pos})
    }

    method piezaContrariaEn(pos) {
        return negro.piezaEn(pos)
    }
}