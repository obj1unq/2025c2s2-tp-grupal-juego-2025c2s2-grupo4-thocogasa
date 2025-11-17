import mecanicas.*
import aliados.*
import UI.*
import wollok.game.*
import oleadas.*


object reyBlanco {
  var property recursos = 100
  var property vidas = 3
  var property position = game.at(2, 0)
  const listaPiezasAliadas = []
  
  method listaPiezasAliadas() = listaPiezasAliadas
  
  method image() =
    if (vidas <= 0) "RBlanco3Hit.png"
    else if (vidas == 1) "RBlanco2Hit.png"
    else if (vidas == 2) "RBlanco1Hit.png"
    else "RBlanco.png"
  
  method esNegro() = false
  
  method moverDerecha() {
    self.validarMover(self.position().right(1))
    position = self.position().right(1)
  }
  
  method moverIzquierda() {
    self.validarMover(self.position().left(1))
    position = self.position().left(1)
  }
  
  method validarMover(unaPosicion) {
    if (!self.puedeMover(unaPosicion)) self.error("")
  }
  
  method añadirRecursos(valor) {
    recursos += valor
  }
  
  method restarRecursos(valor) {
    recursos -= valor
  }

  method desaparece() { // El rey no desaparece de una pero lo necesitamos por el polimorfismo
    self.perderVida()
  }
  
  method perderVida() {
    //sonidos.playGolpeAlRey() // aca para que coincida con el momento. poner otro sonido
    vidas -= 1
  }
  
  method puedeMover(
    unaPosicion
  ) = ((unaPosicion.x() >= 0) && (unaPosicion.x() <= 4)) && mecanicasJuego.juegoActivo()

  method puedeColocar(pieza, ubicacion) {
    const hayRecursos = recursos >= pieza.valor()
    const noHayPieza = not self.hayPiezasAliadas(ubicacion)
    const activo = mecanicasJuego.juegoActivo()
    return recursos >= pieza.valor() && not self.hayPiezasAliadas(ubicacion) && mecanicasJuego.juegoActivo()
  }
//
  //method hayPiezasAliadas(pos) = game.getObjectsIn(pos).filter({ obj => return !obj.esNegro()  }).isEmpty()
//  method hayPiezasAliadas(pos) = listaPiezasAliadas.filter({ obj => obj.position() == pos  }).isEmpty() funciona con esto
  method hayPiezasAliadas(pos) {
    return listaPiezasAliadas.any( { aliado => aliado.position() == pos })
  }

  method intentarColocarPieza(pieza) {
      if (self.puedeColocar(pieza, self.position().up(1)) && !self.hayEnemigoEn(self.position().up(1))) {
        pieza.position(self.position().up(1))
        game.addVisual(pieza)
        listaPiezasAliadas.add(pieza)
        self.restarRecursos(pieza.valor())
      } else if (self.puedeColocar(pieza, self.position().up(1)) && self.hayEnemigoEn(self.position().up(1))) {
        self.restarRecursos(pieza.valor())
        self.desaparecerEnemigoSiHay(self.position().up(1))
      }
  }

  method hayEnemigoEn(posicion){
      return oleada.enemigosActivos().any({enemigo => enemigo.position() == posicion})

  }
  method enemigoEnPosicionADesaparecer(posicion) {
    return if(self.hayEnemigoEn(posicion)) self.enemigoEnPosicion(posicion)
  }
  method enemigoEnPosicion(posicion){
    return oleada.enemigosActivos().find({enemigo => enemigo.position() == posicion})

}
  method desaparecerEnemigoSiHay(pos) {
    const enemigo = self.enemigoEnPosicionADesaparecer(pos)
    if(self.hayEnemigoEn(pos)){
      enemigo.desaparece()
      self.añadirRecursos(enemigo.valor() / 2)
      score.addScore(enemigo.valor() / 2)
    }
  /*
  solocion para multiples enemigos
    const enemigos = oleada.enemigosActivos().filter({ enemigo => 
        return enemigo.position() == pos 
    })
    
    enemigos.forEach({ enemigo => 
        enemigo.desaparece()
        self.añadirRecursos(enemigo.valor() / 2)
        score.addScore(enemigo.valor() / 2) 
    })*/
  }
//
// method hayPiezasAliadas(pos) = game.getObjectsIn(pos).filter({ obj => return !obj.esNegro()  }).isEmpty()
/*
  method intentarColocarPieza(pieza) {
      if (self.puedeColocar(pieza, self.position().up(1)) && !self.hayEnemigoEn(self.position().up(1))) {
        pieza.position(self.position().up(1))
        game.addVisual(pieza)
        listaPiezasAliadas.add(pieza)
        self.restarRecursos(pieza.valor())
      } else if (self.puedeColocar(pieza, self.position().up(1)) && self.hayEnemigoEn(self.position().up(1))) {
        self.restarRecursos(pieza.valor())
        self.desaparecerEnemigoSiHay(self.position().up(1))
      }
  }

  method hayEnemigoEn(pos) = !game.getObjectsIn(pos).filter({ obj => return obj.esNegro() }).isEmpty()

  method desaparecerEnemigoSiHay(pos) {
    const enemigos = game.getObjectsIn(pos).filter({ obj => return obj.esNegro() })
    enemigos.forEach({ enemigo => enemigo.desaparece()
                                  self.añadirRecursos(enemigo.valor() / 2)
                                  score.addScore(enemigo.valor() / 2) })
  }
  */
  method limpiarAliadosInactivos() {
    const aliadosAEliminar = listaPiezasAliadas.filter(
      { aliado => (aliado.position().y() == 0) or (not game.hasVisual(aliado)) }
    )
    aliadosAEliminar.forEach({ aliado => listaPiezasAliadas.remove(aliado) })
  }
  
  method reiniciar() {
    recursos = 100
    vidas = 3
    position = game.at(2, 0)
    listaPiezasAliadas.clear()
  }

  method disparar(proyectil) {
    self.intentarColocarPieza(proyectil)
    proyectil.avanzarYComer()
    }   


}
