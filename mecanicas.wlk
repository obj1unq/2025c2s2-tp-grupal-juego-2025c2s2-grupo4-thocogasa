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
            game.onTick(500, "verificar_colisiones", { => self.verificarTodasLasColisiones() })
        }
    }
    
    method detenerVerificaciones() {
        if (verificacionActiva) {
            verificacionActiva = false
            game.removeTickEvent("verificar_colisiones")
        }
    }
    
    method verificarTodasLasColisiones() {
        const peonesBlancosEnJuego = game.allVisuals().filter({ visual =>
            visual.className() == "aliados.PeonBlanco" or visual.className() == "aliados.Caballos"
        })

        
        peonesBlancosEnJuego.forEach({ peon => peon.intentarCapturar() })
        
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
