import mecanicas.*
import aliados.*
import UI.*
import wollok.game.*
import oleadas.*
import images.*
import pieza.*


class reyBlanco inherits Pieza(ultimaFila = game.height() - 1, color = blanco, vidas = 3, position = game.at(2, 0)){
  var property recursos = 100
  const listaPiezasAliadas = []
  
  method listaPiezasAliadas() = listaPiezasAliadas
  
  override method image() =
    if (vidas <= 0) images.rey1()
    else if (vidas == 1) images.rey2()
    else if (vidas == 2) images.rey3()
    else images.rey()
    
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
  
  method añadirRecursos(_valor) {
    recursos += _valor
  }
  
  method restarRecursos(_valor) {
    recursos -= _valor
  }
  
  method puedeMover(
    unaPosicion
  ) = ((unaPosicion.x() >= 0) && (unaPosicion.x() <= 4)) && mecanicasJuego.juegoActivo()

  method puedeColocar(pieza, ubicacion) {
    return recursos >= pieza.valor() && not self.hayPiezasAliadas(ubicacion) && mecanicasJuego.juegoActivo()
  }

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

  method disparar(proyectil) {
    self.intentarColocarPieza(proyectil)
    proyectil.avanzarYComer()
  }
}
