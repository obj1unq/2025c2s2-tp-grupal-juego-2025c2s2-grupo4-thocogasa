import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import images.*
import oleadas.*
import timers.*
import pieza.*

class Aliado inherits Pieza(ultimaFila = game.height() - 1, color = blanco, accesorio = new Coronación(piezaDueña = self)){
    var property combo = 1
    var property tickName = null
    method posicionesDiagonales()

    override method mover(posiciónx, posicióny) {
        super(posiciónx, posicióny)
        self.intentarCoronar()
    }

    /*// Verificar colisión frontal
        const posicionFrente = self.position().up(1) 
        if (self.posicionValida(posicionFrente) && self.hayEnemigoEnPosicion(posicionFrente)) { 
            const enemigoEnFrente = self.enemigoEnPosicion(posicionFrente) 
                enemigoEnFrente.desaparece() 
                game.schedule(500, { game.removeVisual(self) }) 
                reyBlanco.añadirRecursos(enemigoEnFrente.valor() / 2)
                score.addScore(enemigoEnFrente.valor() / 2)
                capturado = true
        }*/

    method posicionAleatoriaEnDiagonal(posicionesDiagonales) {
        return posicionesDiagonales.anyOne()
    }

    method hayEnemigoEnPosicion(posicion){
        return oleada.enemigosActivos().any({enemigo => enemigo.position() == posicion})

    }

    method enemigoEnPosicion(posicion){
        return oleada.enemigosActivos().find({enemigo => enemigo.position() == posicion})
    }

    override method capturar(enemigo) {
        super(enemigo)
        
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

    method intentarCoronar() {
        if (self.esUltimaFila()) {
            self.coronar()
        }
    }

    method coronar() {
        reyBlanco.añadirRecursos(valor * 5)
        score.addScore(valor * 5)
        self.detenerTick()
        game.addVisual(accesorio)
        game.schedule(1400, { game.removeVisual(self)
                              game.removeVisual(accesorio) })
    }
    //@gabriel HABRIA QUE HACER UN TEMPLATE DE CORONAR CON LAS DISTINTAS PIEZAS PARA CAMBIAR LO DEL VALOR
    
    method detenerTick(){
        if (self.tickName() != null) {
            game.removeTickEvent(self.tickName())
            self.tickName(null)
        }
    }
    
}