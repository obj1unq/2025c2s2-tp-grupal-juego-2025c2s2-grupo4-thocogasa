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
  override method posicionesAvanzables() = [self.position().right(2).down(1), self.position().left(2).down(1), self.position().right(1).down(2), self.position().left(1).down(2)]
}

class TorreNegro inherits Enemigo (valor = 50, imagenPieza = images.torreNegro()) {
  override method posicionesAvanzables() = [self.position().down(1)]
  
}