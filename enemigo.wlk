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
  method siguientePosicion() {
    const candidatos = self.posicionesAvanzables().filter({ posicion => self.posicionValida(posicion) })
    if (candidatos.isEmpty()) {
      // No hay posiciones válidas a las que avanzar: quedarse en la posición actual
      return position
    } else {
      return candidatos.anyOne()
    }
  }

  method posicionValida(posicion) = (((posicion.x() >= 0) && (posicion.x() < 5)) && (posicion.y() >= 0)) && (posicion.y() < game.height())

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
      position = self.siguientePosicion()
    }
    
    self.capturarRey()
  }

  method capturarPieza() { // TODO: Rehacer este método/overridearlo en cada pieza enemiga. Ahora mismo sólo come si está sobre otra pieza, (Y nunca se llama rn)
    const enemigosAcá = game.getObjectsIn(position).filter( { pieza => !pieza.esNegro() } )
    if (not enemigosAcá.isEmpty()) {
        const enemigoAcá = enemigosAcá.first()

        enemigoAcá.desaparece()
    }
  }

  method intentarAñadirJaque() {
    if (!game.hasVisual(jaque)) {
      game.addVisual(jaque)
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