import wollok.game.*
import rey.*
import enemigos.*
import aliados.*
import UI.*
import oleadas.*
import leaderboard.*

object mecanicasJuego {
  var property verificacionActiva = false

  method iniciarVerificaciones() {
    if (not verificacionActiva) {
      verificacionActiva = true
      game.onTick(
        250,
        "verificar_colisiones",
        { self.verificarTodasLasColisiones() }
      )
    }
  }
  
  method detenerVerificaciones() {
    if (verificacionActiva) {
      verificacionActiva = false
      game.removeTickEvent("verificar_colisiones")
    }
  }
  
  method reiniciarJuego() {
    // Detener todas las verificaciones y oleadas
    self.detenerVerificaciones()
    oleada.detenerOleada()
    oleada.nivel(1)
    
    // Limpiar todos los visuales excepto el rey blanco y UI
    const visualesAMantener = [
      reyBlanco,
      score,
      recursos,
      vidas,
      piezasRestantes
    ]
    game.allVisuals().forEach(
      { visual => if (not visualesAMantener.contains(visual)) game.removeVisual(
                      visual
                    ) }
    )
    
    // Resetear estado del rey blanco
    reyBlanco.reiniciar()
    
    // Resetear score
    score.reiniciar()
    
    // Resetear oleada
    oleada.reiniciar()
    
    game.say(reyBlanco, "¡Juego reiniciado!")
    
    // Reiniciar el juego después de 1 segundo
    game.schedule(
      1000,
      { 
        oleada.crearOleada(8)
        oleada.iniciarOleada()
        return self.iniciarVerificaciones()
      }
    )
  }
  
  method gameOver() {
    self.detenerVerificaciones()
    oleada.detenerOleada()
    leaderboard.addCurrentScoreWithName("Jugador")
    leaderboard.show()
  }
  
  method juegoActivo() = verificacionActiva
  
  method verificarTodasLasColisiones() {
    reyBlanco.listaPiezasAliadas().forEach(
      { aliado => aliado.intentarCapturar() }
    )
    
    if (oleada.oleadaCompleta()) self.siguienteNivel()
  }
  
  method siguienteNivel() {
    if (not oleada.estaEnTransicion()) {
      oleada.iniciarTransicion()
      oleada.nivel(oleada.nivel() + 1)
      game.say(reyBlanco, "¡Oleada completada!")
      game.schedule(
        2000,
        { 
          oleada.crearOleada(oleada.nivel() + 5)
          oleada.iniciarOleada()
          oleada.terminarTransicion()
        }
      )
    }
  }
}