import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import images.*

class Enemigo {
  var property position = game.at((0 .. 4).anyOne(), 7) //0.randomUpTo(4)
  var property valor
  var property muerto = false
  var property imagenPieza
  const jaque = new jaqueMate(piezaDueña = self)
  
  method image() {
    if (muerto) {
      return images.piezaMuerta()
    } else {
      return imagenPieza
    }
  }
  
  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }
  
  method esNegro() = true
  
  method avanzar() {
    var contador = 0

    if (position.y() == 1 && contador != 3){
      contador = contador + 1
      game.addVisual(jaque) // WIP. TIENE QUE CHECKEAR SI HAY JAQUE Y ELIMINARLO.
    } else {
      position = game.at(position.x(), (position.y() - 1).max(0))
    }
    
    self.capturarRey()
  }

  method capturarPieza() {
    const enemigosAcá = game.getObjectsIn(position).filter( { pieza => !pieza.esNegro() } )
    
    if (not enemigosAcá.isEmpty()) {
        const enemigoAcá= enemigosAcá.first()

        enemigoAcá.desaparece()
    }
  }
  
  method capturarRey() {
    // TODO: Acá iría el estado jaque. Habría que hacer que el enemigo pare antes de moverse a la última casilla y highlightee la casilla donde iría, dándole al rey una oportunidad.
    if (position.y() == 0) {
      reyBlanco.perderVida()
      if (reyBlanco.vidas() <= 0) {
        game.say(self, "¡Game Over! Presiona R para reiniciar")
        mecanicasJuego.gameOver()
      } else {
        self.desaparece()
      }
    }
  }
}