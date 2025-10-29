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
    position = game.at(position.x(), (position.y() - 1).max(0))
    
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