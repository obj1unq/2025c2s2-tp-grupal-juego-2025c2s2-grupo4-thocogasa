import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import images.*
import oleadas.*
import timers.*

class Aliado {
    var property valor
    var property position = game.at(0, 1)
    var property image
    var property combo = 1
    var property tickName = null
    method posicionesDiagonales() 

    method mover(posiciónx, posicióny) {
        position = game.at(posiciónx, posicióny)
        self.intentarCoronar()
    }

    method estaEnLaUltimaFila() {
        return position.y() == (game.height() - 1)
    }

    method intentarCapturar() {
        var capturado = false
        
        self.posicionesDiagonales().forEach(
        { posicion =>
            if (self.posicionValida(posicion) && not capturado) {
            if (self.hayEnemigoEnPosicion(posicion)) {
                const enemigo = self.enemigoEnPosicion(posicion)
                self.capturarDirectamente(enemigo)
                capturado = true
            }
            } }
        )
        // Verificar colisión frontal
        const posicionFrente = self.position().up(1) 
        if (self.posicionValida(posicionFrente) && self.hayEnemigoEnPosicion(posicionFrente)) { 
            const enemigoEnFrente = self.enemigoEnPosicion(posicionFrente) 
                enemigoEnFrente.desaparece() 
                game.schedule(500, { game.removeVisual(self) }) 
                reyBlanco.añadirRecursos(enemigoEnFrente.valor() / 2)
                score.addScore(enemigoEnFrente.valor() / 2)
                capturado = true
        }

        return capturado
    }
    method posicionAleatoriaEnDiagonal(posicionesDiagonales) {
        return posicionesDiagonales.anyOne()
    }
    method hayEnemigoEnPosicion(posicion){
        return oleada.enemigosActivos().any({enemigo => enemigo.position() == posicion})

    }
    method enemigoEnPosicion(posicion){
        return oleada.enemigosActivos().find({enemigo => enemigo.position() == posicion})

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
        self.detenerTick()
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
        score.addScore(valor * 5)
        self.image(images.peonBlanco(true))
        self.detenerTick()
        game.schedule(1400, { game.removeVisual(self) })
    }
    //@gabriel HABRIA QUE HACER UN TEMPLATE DE CORONAR CON LAS DISTINTAS PIEZAS PARA CAMBIAR LO DEL VALOR


    method esNegro() = false
    
    method detenerTick(){
        if (self.tickName() != null) {
            game.removeTickEvent(self.tickName())
            self.tickName(null)
        }
    }
    
}