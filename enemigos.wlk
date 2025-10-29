import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import enemigo.*
import images.*

class PeonEnemigo inherits Enemigo (valor = 10, imagenPieza = images.peonNegro()) {
  override method posicionesAvanzables() = [self.position().down(1)]
}

class AlfilNegro inherits Enemigo (valor = 30, imagenPieza = images.alfilNegro()) {
  override method posicionesAvanzables() = [null]

  override method avanzar() {
    const diagonalDer = game.at(
      (position.x() + 1).min(4),
      (position.y() - 1).max(0)
    )
    const diagonalIzq = game.at(
      (position.x() - 1).max(0),
      (position.y() - 1).max(0)
    )
    const ambasDiagonales = #{diagonalDer, diagonalIzq}
    
    if (position.x() == 0) {
      position = diagonalDer
    } else {
      if (position.x() == 4) {
        position = diagonalIzq
      } else {
        position = ambasDiagonales.anyOne()
      }
    }
    
  /*  self.capturarPieza() */
    self.capturarRey()
  }

  override method jaquePosition() {
    return null
  }
}

class CaballoNegro inherits Enemigo (valor = 50, imagenPieza = images.caballoNegro()) {
  override method avanzar() {
    
  }
}

/*
object movimientosEnemigos {
  method peones(posicionOrigen){
    return game.at(posicionOrigen.x(), (posicionOrigen.y() - 1).max(0))
  }

  method alfiles(posicionOrigen) {
       return game.at(
        posicionOrigen.x().left(1) , 
        (posicionOrigen.y() - 1).max(0))
  } */
