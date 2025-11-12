import mecanicas.*
import aliados.*
import UI.*
import wollok.game.*

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
    return recursos >= pieza.valor() && self.hayPiezasAliadas(ubicacion) && mecanicasJuego.juegoActivo()
  }

  method hayPiezasAliadas(pos) = game.getObjectsIn(pos).filter({ obj => return !obj.esNegro()  }).isEmpty()

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
}