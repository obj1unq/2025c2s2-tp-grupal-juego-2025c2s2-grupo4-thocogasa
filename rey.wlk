import mecanicas.*
import aliados.*
import UI.*
import wollok.game.*
import oleadas.*
import images.*
import pieza.*


object reyBlanco inherits Pieza ( 
  ultimaFila = game.height() - 1, 
  color = blanco, 
  vidas = 3, 
  position = game.at(2, 0),
  imagePieza = images.rey()

  ) {
  var property recursos = 100
  const property listaPiezasAliadas = []
  
  override method imagePieza() =
    if (vidas <= 0) images.rey1()
    else if (vidas == 1) images.rey2()
    else if (vidas == 2) images.rey3()
    else images.rey()
    
  method moverDerecha() {
    const posicionX = self.position().x()
    const posicionY = self.position().y()
    self.mover(posicionX+1 , posicionY)
  }
  
  method moverIzquierda() {
    const posicionX = self.position().x()
    const posicionY = self.position().y()
    self.mover(posicionX-1 , posicionY)
  }
  
  method añadirRecursos(_valor) {
    recursos += _valor
  }
  
  method restarRecursos(_valor) {
    recursos -= _valor
  }
  
  method puedeColocar(pieza, ubicacion) {
    return self.recursosSuficientesPara(pieza) && 
        not self.hayPiezaDeColor(blanco, ubicacion) && 
          mecanicasJuego.juegoActivo()
  }

  method recursosSuficientesPara(pieza){
    return recursos >= pieza.valor()
  }

  method intentarColocarPieza(pieza) {
      if (self.puedeColocar(pieza, self.position().up(1)) && 
        !color.piezaContrariaEn(self.position().up(1))) {
            self.colocarPiezaEn(pieza, self.position().up(1) )// 
      } else if (
        self.puedeColocar(pieza, self.position().up(1)) && 
        self.hayPiezaDeColor(negro, self.position().up(1))
        ) {
            self.restarRecursos(pieza.valor())
            self.desaparecerEnemigoSiHay(self.position().up(1))
      }
  }

  method colocarPiezaEn(pieza, pos) {
      pieza.position(pos)
      game.addVisual(pieza)
      listaPiezasAliadas.add(pieza)
      self.restarRecursos(pieza.valor())
  } //metí este método para poder disparar directamente desde la posicion del Rey

  method enemigoEnPosicionADesaparecer(posicion) {
    return if(color.hayPiezaContraria(posicion)) color.piezaContrariaEn(posicion)
  }

  method desaparecerEnemigoSiHay(pos) {
    const enemigo = self.enemigoEnPosicionADesaparecer(pos)
    if(color.hayPiezaContraria(pos)){
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
    if (self.recursosSuficientesPara(proyectil)) {
      self.colocarPiezaEn(proyectil, position)
      proyectil.avanzarYComer()
    }
  } //ahora el rey dispara desde su posición, y sólo chequea por validez de recursos
}
