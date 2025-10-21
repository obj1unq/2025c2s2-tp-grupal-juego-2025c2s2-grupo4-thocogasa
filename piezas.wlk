import mecanicas.*
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

  method esNegro() {
    return false
  } // agregue este metodo para resolver un error que aparecia en las colisiones,
  
  method moverDerecha() {
    self.validarMover(self.position().right(1))
    position = self.position().right(1)
    }


  method moverIzquierda() {
    self.validarMover(self.position().left(1))
    position = self.position().left(1)

  }

  method validarMover(unaPosicion){
    if(!self.puedeMover(unaPosicion)){
      self.error("")
    }
  }

  method añadirRecursos(valor) {
    recursos = recursos + valor
  }

  method restarRecursos(valor) {
    recursos = recursos - valor
  }

  method perderVida() {
    //sonidos.playGolpeAlRey() // aca para que coincida con el momento. poner otro sonido
    vidas = vidas - 1
  }

  method puedeMover(unaPosicion) = unaPosicion.x() >= 0 && unaPosicion.x() <= 4 && mecanicasJuego.juegoActivo()

  method intentarColocarPeon() {
    const nuevoPeon = new PeonBlanco(position = self.position().up(1))
    if (self.puedeColocarPeon(nuevoPeon.valor(), self.position().up(1))) { //TODO: cambiar por validación
      game.addVisual(nuevoPeon)
      listaPiezasAliadas.add(nuevoPeon)
      self.restarRecursos(nuevoPeon.valor())
    }
  }

  method puedeColocarPeon(valor, ubicacion) {
    return (recursos >= valor) && game.getObjectsIn(ubicacion).isEmpty() && mecanicasJuego.juegoActivo()
  }

  method colocar(pieza){
    self.puedeColocar(pieza, self.position().up(1))
    game.addVisual(pieza)
    self.restarRecursos(pieza.valor())
  }

  method puedeColocar(pieza, ubicacion) {
    const posicion = game.at(self.position().x().up(1), 0)
    return recursos < pieza.valor() || !game.getObjectsIn(ubicacion).isEmpty() && mecanicasJuego.juegoActivo()
  }

  method intentarColocarCaballo() {
    const nuevoCaballo = new CaballosBlancos(position = self.position().up(1))
    if (self.puedeColocarPeon(nuevoCaballo.valor(), self.position().up(1))) {
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

  method reiniciar() {
    recursos = 100
    vidas = 3
    position = game.at(2,0)
    listaPiezasAliadas.clear()
  }
}

// SE CREAN LAS SUPERCLASES

class Peon {
  //var property position 
  //var property valor 
  var property muerto = false

  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }

  method esNegro() {
    return false
  }

}

class Caballo {
  //var property position 
  //var property valor 
  var property muerto = false

  method image() {
  if (!muerto) { 
    return "CNegro.png"
  } else {
    return "PBlancoMuerto.gif" // lo dejo asi por si mas adelante se ve agrega una imagen para verlo
  }

  } 
  
  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }
  
  method esNegro() {
    return false
  }
    
}
class Alfil {
  var property position 
  var property valor
  var property muerto = false
  
  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }
  method esNegro() {
    return false
  }
}

class Torre {
  var property position 
  var property valor 
  var property muerto = false

  method desaparece() {
    muerto = true
    game.schedule(500, { game.removeVisual(self) })
  }
  method esNegro() {
    return false
  }
}
