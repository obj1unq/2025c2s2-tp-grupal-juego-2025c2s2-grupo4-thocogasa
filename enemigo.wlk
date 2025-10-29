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
  var contador = 0
  
  method posicionesAvanzables()

  method image() {
    if (muerto) {
      return images.piezaMuerta()
    } else {
      return imagenPieza
    }
  }
  
  method desaparece() {
    muerto = true
    if (game.hasVisual(jaque)) {
      game.removeVisual(jaque)
    }
    game.schedule(500, { game.removeVisual(self) })
  }
  
  method esNegro() = true
  
  method avanzar() {
    if (position.y() == 1 && contador <= 3){
      contador = contador + 1
      game.say(self, "contador " + contador)
      self.intentarAñadirJaque()
    } else {
      position = game.at(position.x(), (position.y() - 1).max(0))
    }
    
    self.capturarRey()
  }

  method capturarPieza() {
    const enemigosAcá = game.getObjectsIn(position).filter( { pieza => !pieza.esNegro() } )
    // TODO: Esto no funca bien, hay que hacer que sólo coma a veces, no siempre.
    if (not enemigosAcá.isEmpty()) {
        const enemigoAcá= enemigosAcá.first()

        enemigoAcá.desaparece()
    }
  }

  method intentarAñadirJaque() {
    if (!game.hasVisual(jaque)) {
      game.addVisual(jaque)
    }
  }

  method jaquePosition() {
    return game.at(position.x(), (position.y() - 1).max(0))
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