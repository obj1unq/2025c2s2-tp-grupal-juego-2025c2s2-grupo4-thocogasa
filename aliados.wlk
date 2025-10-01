import piezas.*
import enemigos.*
import wollok.game.*
import UI.*


  class PeonBlanco {
    var property image ="PBlanco.png"
    var property position
    var property valor = 20

    method mover(direccion){
        position = direccion
    }

    method colocarEn(_posicion) {
        const nuevoPeon = new PeonBlanco(position = _posicion)
        game.addVisual(nuevoPeon)
        reyBlanco.restarRecursos(valor)
    }

    method verificarCaptura() {
        const posicionesDiagonales = [self.position().up(1).left(1), self.position().up(1).right(1)]
        
        posicionesDiagonales.forEach({ posicion =>
            if (self.hayPiezaEnemigaEnRango(posicion)) {
                const enemigos = game.getObjectsIn(posicion).filter{p => p.esNegro()}
                if (not enemigos.isEmpty()) {
                    const enemigo = enemigos.first()
                    self.capturar(enemigo)
                }
            }
        })
        
        const posicionFrente = self.position().up(1)
        const enemigosFrente = game.getObjectsIn(posicionFrente).filter{p => p.esNegro()}
        if (not enemigosFrente.isEmpty()) {
            const enemigoFrente = enemigosFrente.first()
            // Ambos peones se destruyen
            self.desaparece()
            reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
            enemigoFrente.desaparece()
            game.say(self, "Colisión!")
        }
    }


    method intentarCapturar() {
        // Verificar posiciones diagonales superiores para captura
        const posicionesDiagonales = [self.position().up(1).left(1), self.position().up(1).right(1)]
        
        posicionesDiagonales.forEach({ posicion =>
            // Verificar que la posición esté dentro del tablero
            if (self.posicionValida(posicion)) {
                const enemigosEnPosicion = game.getObjectsIn(posicion).filter{pieza => pieza.esNegro()}
                if (not enemigosEnPosicion.isEmpty()) {
                    const enemigo = enemigosEnPosicion.first()
                    self.capturarDirectamente(enemigo)
                }
            }
        })
        
        // Verificar colisión frontal
        const posicionFrente = self.position().up(1)
        if (self.posicionValida(posicionFrente)) {
            const enemigosFrente = game.getObjectsIn(posicionFrente).filter{pieza => pieza.esNegro()}
            if (not enemigosFrente.isEmpty()) {
                const enemigoFrente = enemigosFrente.first()
                // Ambos peones se destruyen en colisión frontal
                self.desaparece()
                enemigoFrente.desaparece()
                reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
                game.say(self, "¡Colisión!")
            }
        }
    }
    
    method capturarDirectamente(enemigo) {
        // Captura directa sin verificaciones adicionales
        const posicionCaptura = enemigo.position()
        console.println("Peón en " + self.position() + " captura enemigo en " + posicionCaptura)
        self.mover(posicionCaptura)
        enemigo.desaparece()
        score.addScore(enemigo.valor())
        reyBlanco.añadirRecursos(enemigo.valor())
        game.say(self, "¡Capturado!")
    }
    
    method capturar(pieza) {
        const posicionAtaque = pieza.position() 
        
        if (self.hayPiezaEnemigaEnRango(posicionAtaque)){
            self.mover(posicionAtaque)
            pieza.desaparece()
            score.addScore(pieza.valor())
            reyBlanco.añadirRecursos(pieza.valor())
            game.say(self, "¡Capturado!")
        }
    }

    method hayPiezaEnemigaEnRango(posicion) {
        // 1. ¿Hay enemigo?
        const enemigos = game.getObjectsIn(posicion).filter{p => p.esNegro()}
        const hayEnemigo = not enemigos.isEmpty()
        
        // 2. ¿Está el enemigo en una casilla de captura diagonal válida?
        const enRangoDiagonal = posicion == self.position().up(1).left(1) or 
                                posicion == self.position().up(1).right(1)
                                
        return hayEnemigo and enRangoDiagonal
    }

    method posicionValida(posicion) {
        return posicion.x() >= 0 and posicion.x() < game.width() and 
               posicion.y() >= 0 and posicion.y() < game.height()
    }

    method esNegro() {return false}

    method desaparece() {
        game.removeVisual(self)
    }
  }


  object negro1 {
      var property image = "PNegro.png"
      var property position = game.at(1,2)
      method esNegro() {return true}
      method desaparece() {game.removeVisual(self)}
      // var property valor = 1 
  }

  object negro2 {
      var property image = "PNegro.png"
      var property position = game.at(2,3)
      method esNegro() {return true}
      method desaparece() {game.removeVisual(self)}
      // var property valor = 1
  }

    const blanco1 = new PeonBlanco(image="PBlanco.png", position= game.at(0,1))
    const blanco2 = new PeonBlanco(image="PBlanco.png", position= game.at(2,1))
    const blanco3 = new PeonBlanco(image="PBlanco.png", position= game.at(3,1))

        /*	
	game.addVisual(enemigo)
	game.addVisual(negro1)
	game.addVisual(negro2)
	game.addVisual(blanco1)
	game.addVisual(blanco2)
	game.addVisual(blanco3)*/