import piezas.*
import enemigos.*
import wollok.game.*
import UI.*


  class PeonBlanco {
    var property image ="PBlanco.png"
    var property position
    const valor = 20

    method mover(direccion){
        position = direccion
    }

    method colocarEn(_posicion) {
        const nuevoPeon = new PeonBlanco(position = _posicion)
        game.addVisual(nuevoPeon)
        recursos.restarRecursos(valor)
    }
    
    method valor() {
        return valor
    }

  method capturar(pieza) {
      // Obtener la posición de la pieza a capturar.
      const posicionAtaque = pieza.position() 
      
      // Comprobar si hay una pieza enemiga en esa posición Y si la posición está en el rango de captura.
        if (self.hayPiezaEnemigaEnRango(posicionAtaque)){
            // Si cumple las condiciones, el peón se mueve a esa posición y captura.
            self.mover(posicionAtaque)
            pieza.desaparece()
            score.addScore(pieza.valor())
            recursos.añadirRecursos(pieza.valor())
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
/*
    method capturar(pieza) {
        if (self.hayPiezaEnemigaEnRango(pieza.position())){
            self.mover(pieza.position())
            pieza.desaparece()
            score.addScore(pieza.valor())
        }
    }

    method hayPiezaEnemigaEnRango(posicion) {
        const enemigos = game.getObjectsIn(posicion).filter{p => p.esNegro()}
        return not enemigos.isEmpty()
                    and 
                (posicion == self.position().up(1).left(1) or 
                posicion == self.position().up(1).right(1)) //están uno en diagonal a izquierda o derecha
    }
*/
    method esNegro() {return false}

    method desaparece() {game.removeVisual(self)}
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