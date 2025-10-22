import piezas.*
import enemigos.*
import wollok.game.*
import UI.*

class PeonBlanco inherits Peon {
  var property position
  var property valor = 20
  var property image = "PBlanco.png"
  
  method mover(direccion) {
    position = direccion
    self.coronar()
  }
  
  method estaEnUltimaFila() = position.y() == (game.height() - 1)
  
  method colocarEn(_posicion) {
    const nuevoPeon = new PeonBlanco(position = _posicion)
    game.addVisual(nuevoPeon)
    reyBlanco.restarRecursos(valor)
  }
  
  method verificarCaptura() {
    const posicionesDiagonales = [
      self.position().up(1).left(1),
      self.position().up(1).right(1)
    ]
    
    posicionesDiagonales.forEach(
      { posicion => if (self.hayPiezaEnemigaEnRango(posicion)) {
          const enemigos = game.getObjectsIn(posicion).filter(
            { p => p.esNegro() }
          )
          if (not enemigos.isEmpty()) {
            const enemigo = enemigos.first()
            self.capturar(enemigo)
          }
        } }
    )
    
    const posicionFrente = self.position().up(1)
    const enemigosFrente = game.getObjectsIn(posicionFrente).filter(
      { p => p.esNegro() }
    )
    if (not enemigosFrente.isEmpty()) {
      const enemigoFrente = enemigosFrente.first() // Ambos peones se destruyen
      
      self.desaparece()
      
      reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
      enemigoFrente.desaparece()
    }
  }
  
  method intentarCapturar() {
    // Verificar posiciones diagonales superiores para captura
    const posicionesDiagonales = [
      self.position().up(1).left(1),
      self.position().up(1).right(1)
    ]
    
    posicionesDiagonales.forEach(
      { posicion => // Verificar que la posición esté dentro del tablero
        if (self.posicionValida(posicion)) {
          const enemigosEnPosicion = game.getObjectsIn(posicion).filter(
            { pieza => pieza.esNegro() }
          )
          if (not enemigosEnPosicion.isEmpty()) {
            const enemigo = enemigosEnPosicion.first()
            self.capturarDirectamente(enemigo)
          }
        } }
    )
    
    
    // Verificar colisión frontal
    const posicionFrente = self.position().up(1)
    if (self.posicionValida(posicionFrente)) {
      const enemigosFrente = game.getObjectsIn(posicionFrente).filter(
        { pieza => pieza.esNegro() }
      )
      if (not enemigosFrente.isEmpty()) {
        const enemigoFrente = enemigosFrente.first()
        // Ambos peones se destruyen en colisión frontal
        
        self.desaparece()
        enemigoFrente.desaparece()
        reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
      }
    }
  }
  
  method capturarDirectamente(enemigo) {
    // Captura directa sin verificaciones adicionales
    const posicionCaptura = enemigo.position()
    self.mover(posicionCaptura)
    enemigo.desaparece()
    score.addScore(enemigo.valor())
    reyBlanco.añadirRecursos(enemigo.valor())
  }
  
  method capturar(pieza) {
    const posicionAtaque = pieza.position()
    
    if (self.hayPiezaEnemigaEnRango(posicionAtaque)) {
      self.mover(posicionAtaque)
      score.addScore(pieza.valor())
      reyBlanco.añadirRecursos(pieza.valor())
    }
  }
  
  method hayPiezaEnemigaEnRango(posicion) {
    // 1. ¿Hay enemigo?
    const enemigos = game.getObjectsIn(posicion).filter({ p => p.esNegro() })
    const hayEnemigo = not enemigos.isEmpty()
    
    
    // 2. ¿Está el enemigo en una casilla de captura diagonal válida?
    const enRangoDiagonal = (posicion == self.position().up(1).left(
      1
    )) or (posicion == self.position().up(1).right(1))
    
    return hayEnemigo and enRangoDiagonal
  }
  
  method posicionValida(
    posicion
  ) = (((posicion.x() >= 0) and (posicion.x() < game.width())) and (posicion.y() >= 0)) and (posicion.y() < game.height())
  
  //override method esNegro() {return false}
  override method desaparece() {
    game.removeVisual(self)
  }
  
  method coronar() {
    if (self.estaEnUltimaFila()) {
      reyBlanco.añadirRecursos(valor * 5)
      self.desaparece()
    }
  }
  
  method adquirir() {
    
  }
}

class CaballosBlancos inherits Caballo {
  var property position
  var property valor = 50
  var property image = "CBlanco.png"
  
  method mover(direccion) {
    position = direccion
  }
  
  method colocarEn(_posicion) {
    const nuevoPeon = new PeonBlanco(position = _posicion)
    game.addVisual(nuevoCaballo)
    reyBlanco.restarRecursos(valor)
  }
  
  method verificarCaptura() {
    const posicionesDiagonales = [
      self.position().up(2).left(1),
      self.position().up(2).right(1),
      self.position().up(1).left(2),
      self.position().up(1).right(2),
      self.position().down(2).left(1),
      self.position().down(1).left(2),
      self.position().down(2).right(1),
      self.position().down(1).right(2)
    ]
    
    posicionesDiagonales.forEach(
      { posicion => if (self.hayPiezaEnemigaEnRango(posicion)) {
          const enemigos = game.getObjectsIn(posicion).filter(
            { p => p.esNegro() }
          )
          if (not enemigos.isEmpty()) {
            const enemigo = enemigos.first()
            self.capturar(enemigo)
          }
        } }
    )
    
    const posicionFrente = self.position().up(1)
    const enemigosFrente = game.getObjectsIn(posicionFrente).filter(
      { p => p.esNegro() }
    )
    if (not enemigosFrente.isEmpty()) {
      const enemigoFrente = enemigosFrente.first() // Ambos peones se destruyen
      
      self.desaparece()
      reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
      enemigoFrente.desaparece()
    }
  }
  
  method intentarCapturar() {
    // Verificar posiciones caballo
    const posicionesDiagonales = [
      self.position().up(2).left(1),
      self.position().up(2).right(1),
      self.position().up(1).left(2),
      self.position().up(1).right(2),
      self.position().down(2).left(1),
      self.position().down(1).left(2),
      self.position().down(2).right(1),
      self.position().down(1).right(2)
    ]
    
    posicionesDiagonales.forEach(
      { posicion => // Verificar que la posición esté dentro del tablero
        if (self.posicionValida(posicion)) {
          const enemigosEnPosicion = game.getObjectsIn(posicion).filter(
            { pieza => try {
                return pieza.esNegro()
              } catch e : MessageNotUnderstoodException {
                return false
                console.println("el objeto no entiende esNegro()")
              } }
          ) //quiero ver que hay en la celda
          
          
          
          //console.println("Objetos en " + posicion + ": " + game.getObjectsIn(posicion))
          if (not enemigosEnPosicion.isEmpty()) {
            const enemigo = enemigosEnPosicion.first()
            self.capturarDirectamente(enemigo)
          }
        } }
    )
    
    
    // Verificar colisión frontal
    const posicionFrente = self.position().up(1)
    if (self.posicionValida(posicionFrente)) {
      const enemigosFrente = game.getObjectsIn(posicionFrente).filter(
        { pieza => pieza.esNegro() }
      )
      if (not enemigosFrente.isEmpty()) {
        const enemigoFrente = enemigosFrente.first()
        // Ambas piezas se destruyen en colisión frontal
        
        self.desaparece()
        enemigoFrente.desaparece()
        reyBlanco.añadirRecursos(enemigoFrente.valor() / 2)
      }
    }
  }
  
  method capturarDirectamente(enemigo) {
    // Captura directa sin verificaciones adicionales
    const posicionCaptura = enemigo.position()
    self.mover(posicionCaptura)
    enemigo.desaparece()
    score.addScore(enemigo.valor())
    reyBlanco.añadirRecursos(enemigo.valor())
  }
  
  method capturar(pieza) {
    const posicionAtaque = pieza.position()
    
    if (self.hayPiezaEnemigaEnRango(posicionAtaque)) {
      self.mover(posicionAtaque)
      pieza.desaparece()
      score.addScore(pieza.valor())
      reyBlanco.añadirRecursos(pieza.valor())
    }
  }
  
  method hayPiezaEnemigaEnRango(posicion) {
    // 1. ¿Hay enemigo?
    const enemigos = game.getObjectsIn(posicion).filter({ p => p.esNegro() })
    const hayEnemigo = not enemigos.isEmpty()
    
    
    // 2. ¿Está el enemigo en una casilla de captura diagonal válida?
    const enRangoDiagonal = (((((((posicion == self.position().up(2).left(
      1
    )) or (posicion == self.position().up(2).right(
      1
    ))) or (posicion == self.position().up(1).right(
      2
    ))) or (posicion == self.position().up(1).right(
      2
    ))) or (posicion == self.position().down(2).left(
      1
    ))) or (posicion == self.position().down(2).right(
      1
    ))) or (posicion == self.position().down(1).right(
      2
    ))) or (posicion == self.position().down(1).left(2))
    
    
    return hayEnemigo and enRangoDiagonal
  }
  
  method posicionValida(
    posicion
  ) = (((posicion.x() >= 0) and (posicion.x() < game.width())) and (posicion.y() >= 0)) and (posicion.y() < game.height())
  
  //override method esNegro() {return false}
  override method desaparece() {
    game.removeVisual(self)
  }
  
  method coronar() {
    
  }
  
  method adquirir() {
    
  }
}

const nuevoCaballo = new CaballosBlancos(
  position = reyBlanco.position().right(1)
)

class Negros {
  var property image
  var property position
  var property valor = 10
  
  method esNegro() = true
  
  method desaparece() {
    game.removeVisual(self)
  }
}