import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import images.*

class Aliado {
    var property valor
    var property position = game.at(0, 1)
    var property image
    var property combo = 1
    method posicionesDiagonales() 

    method mover(posiciónx, posicióny) {
        position = game.at(posiciónx, posicióny)
    }

    method estaEnLaUltimaFila() {
        return position.y() == (game.height() - 1)
    }

    method intentarCapturar() {
        var capturado = false

        self.posicionesDiagonales().forEach(
        { posicion =>
            if (self.posicionValida(posicion)) {
            const enemigosEnPosicion = game.getObjectsIn(posicion).filter({ pieza => return pieza.esNegro() })

            if (not enemigosEnPosicion.isEmpty()) {
                const enemigo = enemigosEnPosicion.first()
                self.capturarDirectamente(enemigo)
                capturado = true
            }
            } }
        )

        // Verificar colisión frontal
        const posicionFrente = self.position().up(1)
        if (self.posicionValida(posicionFrente)) {
        const enemigosFrente = game.getObjectsIn(posicionFrente).filter(
            { pieza => return pieza.esNegro() }
        )
            if (not enemigosFrente.isEmpty()) {
                const enemigoFrente = enemigosFrente.first()
                enemigoFrente.desaparece()
                game.schedule(500, { game.removeVisual(self) })
                reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
                capturado = true
            }
        }

        return capturado
    }

    method capturarDirectamente(enemigo) {

        const posicionCaptura = enemigo.position()
        self.mover(posicionCaptura.x(), posicionCaptura.y())
        enemigo.desaparece()
        
        reyBlanco.añadirRecursos(enemigo.valor() * combo)
        score.addScore(enemigo.valor() * combo)
        combo = combo + 1
        if(combo > 1){
            game.say(self, "x" + combo)
        }
        game.schedule(2000, {self.reiniciarCombos()})

    }

    method reiniciarCombos(){
        combo = 1
    }

    method posicionValida(posicion) = (((posicion.x() >= 0) and (posicion.x() < game.width())) and (posicion.y() >= 0)) and (posicion.y() < game.height())
    
    method desaparece() {
        game.schedule(500, {
            const capturó = self.intentarCapturar()
            if (not capturó) {
                game.removeVisual(self)
            }
        })
    }

    method intentarCoronar() {
        if (self.estaEnLaUltimaFila()) {
            self.coronar()
        }
    }

    method coronar() {
        reyBlanco.añadirRecursos(valor * 5)
        self.image(images.peonBlanco(true))
        game.schedule(1400, { game.removeVisual(self) })
    }

    method esNegro() = false
    
}