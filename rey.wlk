import mecanicas.*
import aliados.*
import UI.*
import wollok.game.*
import oleadas.*
import images.*
import pieza.*
import trucos.*
import board.*

object reyBlanco inherits Pieza ( 
  ultimaFila = game.height() - 1, 
  color = blanco, 
  vidas = if (trucos.hardmode()) 0 else 3,
  position = game.at(2, 0),
  imagePieza = images.rey()

  ) {
  var property recursos = 100
  const property listaPiezasAliadas = []

  method piezasActivas() = listaPiezasAliadas
  
  override method image() =
    if (vidas <= 0) images.rey3()
    else if (vidas == 1) images.rey2()
    else if (vidas == 2) images.rey1()
    else if (trucos.modoDios()) images.reyDios()
    else images.rey()
  
  method puedeColocar(pieza, ubicacion) {
    return self.recursosSuficientesPara(pieza) && 
        not self.hayPiezaDeColor(blanco, ubicacion) && 
          mecanicasJuego.juegoActivo()
  }

  method recursosSuficientesPara(pieza){
    return recursos >= pieza.valor()
  }

  method intentarColocarPieza(pieza) {
      const destino = self.position().up(1)
      if (self.puedeColocar(pieza, destino) && !color.hayPiezaContraria(destino)) {
            self.colocarPiezaEn(pieza, destino)
      } else if (self.puedeColocar(pieza, destino) && self.hayPiezaDeColor(negro, destino)) {
            recurso.restarRecursos(pieza.valor())
            self.desaparecerEnemigoSiHay(destino)
      }
  }

  method colocarPiezaEn(pieza, pos) {
      pieza.position(pos)
      game.addVisual(pieza)
      listaPiezasAliadas.add(pieza)
      board.ensureInit()
      game.schedule(0, { board.registerPiece(pieza) })
      recurso.restarRecursos(pieza.valor())
  }

  method enemigoEnPosicionADesaparecer(posicion) {
    return if(color.hayPiezaContraria(posicion)) color.piezaContrariaEn(posicion)
  }

  method desaparecerEnemigoSiHay(pos) {
    const enemigo = self.enemigoEnPosicionADesaparecer(pos)
    if(color.hayPiezaContraria(pos)){
      enemigo.desaparece(500)
      recurso.añadirRecursos(enemigo.valor() / 2)
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
    position = game.at(2, 0)
    
    listaPiezasAliadas.clear()
  }

  method disparar(proyectil) {
    if (self.recursosSuficientesPara(proyectil)) {
      self.colocarPiezaEn(proyectil, position)
      proyectil.avanzarYComer()
    }
  }
}