import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import images.*
import oleadas.*
import pieza.*

class Enemigo inherits Pieza(position = game.at((0 .. 4).anyOne(), 7), ultimaFila = 0, color = negro, accesorio = new JaqueMate(piezaDueña = self)){
  var contador = 3
  method posicionesAvanzables()

  method siguientePosicion() {
    const candidatos = self.posicionesAvanzables().filter({ posicion => self.posicionValida(posicion) })
    return if (candidatos.isEmpty()) position else candidatos.anyOne()
  }
    
  method avanzar() {
    if (not muerto) {
      if (position.y() == 1 && contador <= 1){
        contador = contador - 1
        game.say(self, "contador " + contador)
        self.intentarAñadirJaque()
      } else {
        self.mover(self.siguientePosicion().x(), self.siguientePosicion().y())
      }

      self.intentarCapturar()
      self.capturarRey()
    }
  }

  method intentarAñadirJaque() {
    // No añadir jaque si el enemigo ya está muerto.
    if (not muerto && !game.hasVisual(accesorio)) {
      game.addVisual(accesorio)
    }
  }
  
  method capturarRey() {
    if (position.y() == 0) {
      if (reyBlanco.vidas() <= 0) {
        game.say(reyBlanco, "¡Game Over! Presiona R para reiniciar")
        mecanicasJuego.gameOver()
      } else {
        reyBlanco.perderVida()
        self.desaparece()
      }
    }
  }
}