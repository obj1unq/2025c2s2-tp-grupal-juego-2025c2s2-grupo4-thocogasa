import wollok.game.*
import rey.*
import enemigos.*
import aliados.*
import UI.*
import sound.*
import mecanicas.*
import oleadas.*
import leaderboard.*
import escenas.cambioDeEscena.*
import proyectiles.*

object ajedrez inherits Escena {
	
	override method mostrar() {
		game.addVisual(reyBlanco)
		visuales.add(reyBlanco)
		
		oleada.crearOleada(5)
		game.showAttributes(reyBlanco)
		
		//UI
		game.addVisual(score)
		visuales.add(score)
		game.addVisual(recurso)
		visuales.add(recurso)
		game.addVisual(vida)
		visuales.add(vida)
		game.addVisual(piezasRestantes)
		visuales.add(piezasRestantes)
		
		
		// Controles
		game.addVisual(controles)
		visuales.add(controles)
		controles.init()

		keyboard.l().onPressDo({ leaderboard.toggle() })
		
		//Reiniciar juego
		keyboard.alt().onPressDo({ mecanicasJuego.reiniciarJuego() })
		// Empieza solo a los 2 segundos
		game.schedule(
			2000,
			{ 
				sonidos.playFondo()
				oleada.iniciarOleada()
				mecanicasJuego.iniciarVerificaciones()
			}
		)
	}
	
	override method ocultar() {
		mecanicasJuego.detenerVerificaciones()
		
		oleada.detenerOleada()
		oleada.reiniciar()
		
		super()
	}
}

object controles {
	var property position = game.center()
	method init() {
		console.println("Controles Init")
		keyboard.right().onPressDo({ reyBlanco.mover(reyBlanco.position().x() + 1, reyBlanco.position().y()) })
		keyboard.left().onPressDo({ reyBlanco.mover(reyBlanco.position().x() - 1, reyBlanco.position().y()) })
		keyboard.num(1).onPressDo(
			{ reyBlanco.intentarColocarPieza(new PeonBlanco()) }
		)
		keyboard.num(2).onPressDo(
			{ reyBlanco.intentarColocarPieza(new CaballoBlanco()) }
		)

		keyboard.num(3).onPressDo(
			{reyBlanco.disparar(new AlfilBlanco())}
		)

		keyboard.num(4).onPressDo(
			{reyBlanco.disparar(new TorreBlanca())}
		)
	}
}