import wollok.game.*
import piezas.*

object enemigo {
const property positionX = 0.randomUpTo(game.width() - 2)// 
var property position = game.at(self.positionX(),7)
  method image() {
    return "PNegroSilla.png"
  }//aca se crea aleatorio

//altura = 7 y ancho = 4

  
}