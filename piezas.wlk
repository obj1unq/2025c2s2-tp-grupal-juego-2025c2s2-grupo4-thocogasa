import aliados.*
import UI.*
import wollok.game.*

object reyBlanco {
  var property recursos = 100
  var property vidas = 3

  var property position = game.at(2,0)

  const listaPiezasAliadas = []
  
  method listaPiezasAliadas() = listaPiezasAliadas
  
  method image() {
    if (vidas == 2) {
      return "RBlanco1Hit.png"
    } else if (vidas == 1) {
      return "RBlanco2Hit.png"
    } else if (vidas <= 0) {
      return "RBlanco3Hit.png"
    } else {
      return "RBlanco.png"
    }
  }

  method moverDerecha() {
    if(self.puedeMover(self.position().right(1))){
      position = self.position().right(1)
    }
  }

  method moverIzquierda() {
    if(self.puedeMover(self.position().left(1))){
      position = self.position().left(1)
    }
  }

  method añadirRecursos(valor) {
    recursos = recursos + valor
  }

  method restarRecursos(valor) {
    recursos = recursos - valor
  }

  method perderVida() {
    vidas = vidas - 1
  }

  method puedeMover(unaPosicion) = unaPosicion.x() >= 0 && unaPosicion.x() <= 4 

  method intentarColocarPeon() {
    const nuevoPeon = new PeonBlanco(position = self.position().up(1))
    if (self.puedeColocarPeon(nuevoPeon.valor(), self.position().up(1))) {
      game.addVisual(nuevoPeon)
      listaPiezasAliadas.add(nuevoPeon)
      self.restarRecursos(nuevoPeon.valor())
    }
  }

  method puedeColocarPeon(valor, ubicacion) {
    return (recursos >= valor) and game.getObjectsIn(ubicacion).isEmpty()
  }

  method colocar(pieza){
    self.puedeColocar(pieza, self.position().up(1))
    game.addVisual(pieza)
    self.restarRecursos(pieza.valor())
  }

  method puedeColocar(pieza, ubicacion) {
    const posicion = game.at(self.position().x().up(1), 0)
    if ((recursos < pieza.valor()) or !game.getObjectsIn(ubicacion).isEmpty()) { 
      self.error("no se puede colocar pieza")} 
    
  }

    method intentarColocarCaballo() {
    const nuevoCaballo = new Caballos(position = game.at(self.position().x().max(1), 0))
    if (self.puedeColocarPeon(nuevoCaballo.valor(), self.position().left(1))) {
      game.addVisual(nuevoCaballo)
      listaPiezasAliadas.add(nuevoCaballo)
      self.restarRecursos(nuevoCaballo.valor())
    }
  }

  method limpiarAliadosInactivos() {
      const aliadosAEliminar = listaPiezasAliadas.filter({ aliado => 
          aliado.position().y() == 0 or not game.hasVisual(aliado)
      })
      aliadosAEliminar.forEach({ aliado => listaPiezasAliadas.remove(aliado) })
  }
}


/*
object reyNegro {
  method image() {
    return "RNegro.png"
  }

  var property position = game.at(2,7)
  }*/

/*
  class Peon {
    var property image
    var property position
  }

  const negro1 = new Peon(image="PNegroSilla.png", position=game.at(0,6) )
  const negro2 = new Peon(image="PNegroSilla.png", position=game.at(1,6) )
  const negro3 = new Peon(image="PNegroSilla.png", position=game.at(2,6) )
  const negro4 = new Peon(image="PNegroSilla.png", position=game.at(3,6) )
  const negro5 = new Peon(image="PNegroSilla.png", position=game.at(4,6) )

  const blanco1 = new Peon(image="PBlanco.png", position= game.at(0,1))
  const blanco2 = new Peon(image="PBlanco.png", position= game.at(1,1))
  const blanco3 = new Peon(image="PBlanco.png", position= game.at(2,1))
  const blanco4 = new Peon(image="PBlanco.png", position= game.at(3,1))
  const blanco5 = new Peon(image="PBlanco.png", position= game.at(4,1))
*/