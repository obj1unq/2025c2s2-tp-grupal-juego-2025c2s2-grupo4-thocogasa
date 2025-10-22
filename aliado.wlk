import rey.*
import enemigos.*
import wollok.game.*
import UI.*

class Aliado {
    var property valor
    var property position = game.at(0, 1)
    var property image
    method posicionesDiagonales() 

    method mover(posiciónx, posicióny) {
        position = game.at(posiciónx, posicióny)
    }

    method estaEnLaUltimaFila() {
        return position.y() == (game.height() - 1)
    }

    method intentarCapturar() {
        self.posicionesDiagonales().forEach(
        { posicion => // Verificar que la posición esté dentro del tablero
            if (self.posicionValida(posicion)) {
            const enemigosEnPosicion = game.getObjectsIn(posicion).filter(
                { pieza => try {
                    return pieza.esNegro()
                } catch e : MessageNotUnderstoodException {
                    return false
                    console.println("el objeto no entiende esNegro()")
                } }
            )
      
            if (not enemigosEnPosicion.isEmpty()) {
                const enemigo = enemigosEnPosicion.first()
                self.capturarDirectamente(enemigo)
            }
            } }
        )
        
        // Verificar colisión frontal
        const posicionFrente = self.position().up(1)
        if (self.posicionValida(posicionFrente)) {
        const enemigosFrente = game.getObjectsIn(posicionFrente).filter(
            { pieza => pieza.esNegro() }
        )
            if (not enemigosFrente.isEmpty()) {
                const enemigoFrente = enemigosFrente.first()
                // Ambas piezas se destruyen en colisión frontal
                
                self.desaparece()
                enemigoFrente.desaparece()
                reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
            }
        }
    }

    method capturarDirectamente(enemigo) {
        const posicionCaptura = enemigo.position()
        self.mover(posicionCaptura.x(), posicionCaptura.y())
        enemigo.desaparece()
        score.addScore(enemigo.valor())
        reyBlanco.añadirRecursos(enemigo.valor())
    }

    method posicionValida(posicion) = (((posicion.x() >= 0) and (posicion.x() < game.width())) and (posicion.y() >= 0)) and (posicion.y() < game.height())
    
    method desaparece() {
        game.schedule(500, { game.removeVisual(self) })
    }

    method coronar() {
        if (self.estaEnLaUltimaFila()) {
            reyBlanco.añadirRecursos(valor * 5)
            self.desaparece()
        }
    }

    method esNegro() = false
    
}