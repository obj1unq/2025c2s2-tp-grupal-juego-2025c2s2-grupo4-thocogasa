import wollok.game.*
import piezas.*
import enemigos.*
import aliados.*
import UI.*

object mecanicasJuego {
    var property verificacionActiva = false
    
    method iniciarVerificaciones() {
        if (not verificacionActiva) {
            verificacionActiva = true
            game.onTick(250, "verificar_colisiones", { => self.verificarTodasLasColisiones() })
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
        sonidos.detenerTodo()

        // Limpiar todos los visuales excepto el rey blanco y UI
        const visualesAMantener = [reyBlanco, score, recursos, vidas, piezasRestantes]
        game.allVisuals().forEach({ visual =>
            if (not visualesAMantener.contains(visual)) {
                game.removeVisual(visual)
            }
        })
        
        // Resetear estado del rey blanco
        reyBlanco.reiniciar()
        
        // Resetear score
        score.reiniciar()
        
        // Resetear oleada
        oleada.reiniciar()
        
        game.say(reyBlanco, "¡Juego reiniciado!")
        
        // Reiniciar el juego después de 1 segundo
        game.schedule(1000, {
            oleada.crearOleada(8)
            oleada.iniciarOleada()
            self.iniciarVerificaciones()
            sonidos.iniciarMusicaDeFondo()
            sonidos.playSonidoDeFondo()
        })
    }
    
    method gameOver() {
        // Detener todas las verificaciones y oleadas pero mantener el juego corriendo
        self.detenerVerificaciones()
        oleada.detenerOleada()
        sonidos.detenerTodo()
        sonidos.playGameOver()
        // El juego sigue corriendo, solo se detienen las mecánicas
        // El jugador puede presionar R para reiniciar
    }

    method juegoActivo() {
        return verificacionActiva
    }
    
    method verificarTodasLasColisiones() {
        reyBlanco.listaPiezasAliadas().forEach({ aliado => aliado.intentarCapturar() })
        
        if (oleada.oleadaCompleta()) {
            self.siguienteNivel()
        }
    }
    
    method siguienteNivel() {
        game.say(reyBlanco, "¡Oleada completada!")
        game.schedule(2000, { => 
            oleada.crearOleada(oleada.enemigosRestantes() + 3)
            oleada.iniciarOleada()
        })
    }
}
