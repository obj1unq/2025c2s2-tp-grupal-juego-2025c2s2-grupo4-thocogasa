import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import enemigo.*
import images.*

class PeonEnemigo inherits Enemigo (valor = 10) {
  method image() {
    if (muerto) {
      return images.peonMuerto()
    } else {
      return images.peonNegro()
    }
  }
}

class AlfilNegro inherits Enemigo (valor = 30) {
  method image() = images.alfilNegro()
  
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
    
    self.capturarRey()
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
