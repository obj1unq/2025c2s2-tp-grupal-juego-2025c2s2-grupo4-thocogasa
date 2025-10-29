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
  override method posicionesAvanzables() = [self.position().right(1).down(1), self.position().left(1).down(1)]
}

class CaballoNegro inherits Enemigo (valor = 50, imagenPieza = images.caballoNegro()) { 
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
